





import UIKit

class HabitViewController: UIViewController {
    
    private var detailedInformationOfHabit: Habit?
    
    var delegate: CloseHabitDetailsViewController?
    
    static func storyboardInstance(detailedInformationOfHabit: Habit) -> HabitViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc =  storyboard.instantiateViewController(withIdentifier: String(describing: HabitViewController.self)) as? HabitViewController
        vc?.detailedInformationOfHabit = detailedInformationOfHabit
        return vc
    }
    
    @IBOutlet weak var colorPicker: UIButton!  {
        didSet {
            colorPicker.backgroundColor = detailedInformationOfHabit?.color
        }
    }
    
    @IBAction func createColorPicker(_ sender: Any) {
        presentColorPicKer ()
    }
    
    func presentColorPicKer () {
        let colorPicker =  UIColorPickerViewController()
        colorPicker.delegate = self
        colorPicker.selectedColor = detailedInformationOfHabit!.color
        colorPicker.title = "Выбрать цвет"
        present(colorPicker, animated: true, completion: nil)
    }
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var writeHabit: UITextField! {
        didSet {
            writeHabit.font = UIFont.systemFont(ofSize: 16, weight: .regular)
            writeHabit.text = detailedInformationOfHabit?.name
        }
    }
    
    @IBOutlet weak var navigationBar: UINavigationItem! {
        didSet {
            navigationBar.title = "Править"
        }
    }
    
    @IBAction func closeHabit(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveHabit(_ sender: Any) {
        for (index, value) in HabitsStore.shared.habits.enumerated() {
            if value == self.detailedInformationOfHabit {
            HabitsStore.shared.habits.remove(at: index)
                guard let writeOptinal = writeHabit.text else { return }
                guard let colorOptional = colorPicker.backgroundColor else { return }
                let newHabit = Habit(name: writeOptinal, date: pickDateForHabit.date, trackDates: value.trackDates, color: colorOptional)
                let store = HabitsStore.shared
                store.habits.insert(newHabit, at: index)
                NotificationCenter.default.post(name: Notification.Name.init("DidChangeHabbits"), object: nil)
                self.dismiss(animated: true, completion: nil)
                self.delegate?.closeHabitDetailsViewController()
            }
        }
    }
    
    @IBAction func removeHabit(_ sender: Any) {
        guard let writeOptinal = detailedInformationOfHabit?.name else { return }
        let alertController = UIAlertController(title: "Удалить привычку?", message: "Выхотите удалить привычку \(writeOptinal) ?", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Отмена", style: .default) { _ in }
        let deleteAction = UIAlertAction(title: "Удалить", style: .destructive) { _ in
            let habit = self.detailedInformationOfHabit
            for (index, value) in HabitsStore.shared.habits.enumerated() {
                if value == habit {
                    HabitsStore.shared.habits.remove(at: index)
                    NotificationCenter.default.post(name: Notification.Name.init("DidChangeHabbits"), object: nil)
                    self.dismiss(animated: true, completion: nil)
                    self.delegate?.closeHabitDetailsViewController()
                }
            }
        }
        alertController.addAction(cancelAction)
        alertController.addAction(deleteAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.timeStyle = .short
        return formatter
    }()
    
    @IBOutlet weak var pickDateForHabit: UIDatePicker! {
        didSet  {
            pickDateForHabit.datePickerMode = .time
            pickDateForHabit.preferredDatePickerStyle = .wheels
            pickDateForHabit.addTarget(self, action: #selector(saveDate(sender:)), for: .valueChanged)
        }
    }
    
    @objc func saveDate(sender: UIDatePicker) {
        informationAboutDateHabit.text = "Каждый день в \(dateFormatter.string(from: sender.date)) "
    }
    
    @IBOutlet weak var informationAboutDateHabit: UILabel! {
        didSet{
            informationAboutDateHabit.text = "Каждый день в \(dateFormatter.string(from: detailedInformationOfHabit!.date)) "
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        colorPicker.layer.cornerRadius = colorPicker.bounds.height / 2
        pickDateForHabit.date = detailedInformationOfHabit!.date
    }
    //    MARK:- call Keyboard
    /// Keyboard observers
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: Keyboard actions
    @objc fileprivate func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            
            scrollView.contentInset.bottom = keyboardSize.height
            scrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        }
    }
    
    @objc fileprivate func keyboardWillHide(notification: NSNotification) {
        scrollView.contentInset.bottom = .zero
        scrollView.verticalScrollIndicatorInsets = .zero
    }
}
// MARK:- change color through ColorPicker
extension HabitViewController:  UIColorPickerViewControllerDelegate {
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        colorPicker.backgroundColor = viewController.selectedColor
    }
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        print("Color picked")
    }
}
