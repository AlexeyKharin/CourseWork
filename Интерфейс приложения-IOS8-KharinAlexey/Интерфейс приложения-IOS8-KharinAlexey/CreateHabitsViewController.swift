//
//  CreateHabitsViewController.swift
//  Интерфейс приложения-IOS8-KharinAlexey
//
//  Created by Alexey Kharin on 28.02.2021.
//

import UIKit

class CreateHabitsViewController: UIViewController {
    
    static func storyboardInstance() -> CreateHabitsViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc =  storyboard.instantiateViewController(withIdentifier: String(describing: CreateHabitsViewController.self)) as? CreateHabitsViewController
        return vc
    }
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    
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
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.timeStyle = .short
        return formatter
    }()
    
    @IBOutlet weak var navigationBar: UINavigationItem! {
        didSet {
            navigationBar.title = "Создать"
        }
    }
    
    @IBOutlet weak var informationAboutDateHabit: UILabel! {
        didSet{
            informationAboutDateHabit.text = "Каждый день в \(dateFormatter.string(from: Date())) "
                    }
    }
    
    @IBOutlet weak var colorPicker: UIButton! {
        didSet {
            colorPicker.backgroundColor = .orange
        }
    }
    
    func presentColorPicKer () {
        let colorPicker =  UIColorPickerViewController()
        colorPicker.delegate = self
        colorPicker.selectedColor = .orange
        colorPicker.title = "Выбрать цвет"
        present(colorPicker, animated: true, completion: nil)
    }
    
    @IBAction func pickColor(_ sender: Any) {
        presentColorPicKer()
    }
    
    @IBOutlet weak var write: UITextField! {
        didSet {
            write.font = UIFont.systemFont(ofSize: 16, weight: .regular)
            write.placeholder = "Бегать по утрам, спать 8 часов и т.п."
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorPicker.layer.cornerRadius = colorPicker.bounds.height / 2
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
    //    MARK:- closeHabit
    
    @IBAction func closeHabit(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    //    MARK:- createHabit
    @IBAction func createHabit(_ sender: Any) {
        guard let writeOptinal = write.text else { return write.text = " "}
        guard let colorOptional = colorPicker.backgroundColor else { return
            colorPicker.backgroundColor = .orange }
        let newHabit = Habit(name: writeOptinal, date:  pickDateForHabit.date, color: colorOptional)
        let store = HabitsStore.shared
        store.habits.append(newHabit)
        NotificationCenter.default.post(name: Notification.Name.init("DidChangeHabbits"), object: nil)
        dismiss(animated: true, completion: nil)
    }
}
// MARK:- change color through ColorPicker
extension CreateHabitsViewController:  UIColorPickerViewControllerDelegate {
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        colorPicker.backgroundColor = viewController.selectedColor
    }
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        print("Color picked")
    }
}
