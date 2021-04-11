

import UIKit

class HabitsViewController: UIViewController {
    
    lazy var openWindowButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "plus")?.withTintColor(UIColor(red: 161/255, green: 22/255, blue: 204/255, alpha: 0.5)).withRenderingMode(.alwaysOriginal), for:.normal)
        button.addTarget(self, action: #selector(openCreateHabitsViewController) , for: .touchUpInside)
        return button
    }()
    
    @objc func openCreateHabitsViewController() {
        if let vc = CreateHabitsViewController.storyboardInstance() {
        navigationController?.present(vc, animated: true, completion: nil)
    }
    }
    
    private let layout = UICollectionViewFlowLayout()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemGray6
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(
            ProgressCellCollection.self,
            forCellWithReuseIdentifier: String(describing: ProgressCellCollection.self)
        )
        collectionView.register(
            HabitCollectionViewCell.self,
            forCellWithReuseIdentifier: String(describing:  HabitCollectionViewCell.self)
        )
        return collectionView
    }()
    
    let customNavigationBar = UINavigationBar()
    let titlelabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(customNavigationBar)
        view.addSubview(collectionView)
        [openWindowButton, titlelabel].forEach { customNavigationBar.addSubview($0) }
        customNavigationBar.frame = CGRect(
            x: .zero,
            y: .zero,
            width: self.view.bounds.width,
            height: 100)
       
        titlelabel.text = "Сегодня"
        titlelabel.textColor = .black
        titlelabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        layout.scrollDirection = .vertical
        NotificationCenter.default.addObserver(self, selector: #selector(didChangedHabbits), name: Notification.Name.init("DidChangeHabbits"), object: nil)
    }

    @objc private func didChangedHabbits() {
        collectionView.reloadData()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        collectionView.frame = CGRect(
            x: .zero,
            y: customNavigationBar.frame.maxY,
            width: view.bounds.width,
            height: view.bounds.height - customNavigationBar.frame.size.height)
        titlelabel.frame = CGRect(
            x: 20,
            y: 65,
            width: 200,
            height: 30)
        openWindowButton.frame =  CGRect(
            x: view.bounds.size.width - 50,
            y: 40,
            width: 30,
            height: 30)
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
}

extension HabitsViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        default:
            return HabitsStore.shared.habits.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section  {
        case 0 :
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: String(describing: ProgressCellCollection.self),
                for: indexPath) as! ProgressCellCollection
                cell.progressInformation = HabitsStore.shared.todayProgress
            return cell
            
            default:
            let cellContented = HabitsStore.shared.habits[indexPath.item]
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: String(describing: HabitCollectionViewCell.self),
                for: indexPath) as! HabitCollectionViewCell
                cell.informationOfHabit = cellContented
                cell.changeDelegate = self
                
                if HabitsStore.shared.habit(cellContented, isTrackedIn: Date()) {
                cell.switcher = true
                } else {
                cell.switcher = false
                }
                
                var array: [Date] = []
                for date in HabitsStore.shared.dates {
                    if HabitsStore.shared.habit(cellContented, isTrackedIn: date) {
                        array.append(date)
                    }
                }
                cell.countHabits = array.count      
            return cell
        }
    }
}



extension HabitsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch  indexPath.section {
        case 0 :
            let width: CGFloat = (collectionView.bounds.width - 12*2)
            return CGSize(width: width, height: 60)
        default:
            let width: CGFloat = (collectionView.bounds.width - 12*2)
            return CGSize(width: width, height: 130)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch section {
        case 0:
            return UIEdgeInsets(top: 22, left: 12, bottom: 18, right: 12)
        default:
            return UIEdgeInsets(top: 0, left: 12, bottom: 12, right: 12)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch  indexPath.section {
        case 0:
            print("")
        default:
            let cellContented = HabitsStore.shared.habits[indexPath.item]
            let vc = HabitDetailsViewController(detailedInformationOfHabit:  cellContented)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset.y)
    }
}

protocol  ReloadData {
    func didChangeHabits()
}

extension HabitsViewController: ReloadData {
    func didChangeHabits() {
        collectionView.reloadData()
    }
}

