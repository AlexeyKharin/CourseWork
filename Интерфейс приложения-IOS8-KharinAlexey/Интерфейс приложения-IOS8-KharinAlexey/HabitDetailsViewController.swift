//
//  HabitDetailsViewController.swift
//  Интерфейс приложения-IOS8-KharinAlexey
//
//  Created by Alexey Kharin on 11.03.2021.
//

import UIKit

class HabitDetailsViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .systemGray6
        tableView.dataSource = self
        tableView.delegate = self
        tableView.toAutoLayout()
//        tableView.register(HabitDetailsHeader.self, forHeaderFooterViewReuseIdentifier: String(describing: HabitDetailsHeader.self))
        tableView.register(HabitDetailsCell.self, forCellReuseIdentifier: String(describing: HabitDetailsCell.self))
        return tableView
    }()
    
    private let detailedInformationOfHabit: Habit
    
    init(detailedInformationOfHabit: Habit) {
        self.detailedInformationOfHabit = detailedInformationOfHabit
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var buttonBack: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Сегодня", for: .normal)
        button.setImage(UIImage(systemName: "chevron.backward")!.applyingSymbolConfiguration(.init(scale: .large))! .withTintColor(UIColor(red: 161/255, green: 22/255, blue: 204/255, alpha: 0.5)).withRenderingMode(.alwaysOriginal), for:.normal)
        button.setTitleColor( UIColor(red: 161/255, green: 22/255, blue: 204/255, alpha: 0.5), for: .normal)
        button.addTarget(self, action: #selector(back), for: .touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        return button
    }()
    
    lazy var buttonChageHabit: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Править", for: .normal)
        button.setTitleColor( UIColor(red: 161/255, green: 22/255, blue: 204/255, alpha: 0.5), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        button.addTarget(self, action: #selector(change), for: .touchUpInside)
        return button
    }()
    
    @objc func back() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func change() {
        if let vc = HabitViewController.storyboardInstance(detailedInformationOfHabit: detailedInformationOfHabit) {
            vc.delegate = self
            print("\(HabitsStore.shared.habits.count)")
            navigationController?.present(vc, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = detailedInformationOfHabit.name
        view.backgroundColor = .white
        self.navigationItem.setRightBarButton(UIBarButtonItem(customView: buttonChageHabit), animated: true);
        self.navigationItem.setLeftBarButton(UIBarButtonItem(customView: buttonBack), animated: true);
        view.addSubview(tableView)
        let constraints = [
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
// MARK: - UITableViewDataSource
extension HabitDetailsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HabitsStore.shared.dates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: HabitDetailsCell = tableView.dequeueReusableCell(
            withIdentifier: String(describing: HabitDetailsCell.self),
            for: indexPath) as! HabitDetailsCell
        
        cell.dates = HabitsStore.shared.trackDateString(forIndex: indexPath.row)
        if HabitsStore.shared.habit(detailedInformationOfHabit, isTrackedIn: HabitsStore.shared.dates[indexPath.row])  {
            cell.tintColor = UIColor(red: 161/255, green: 22/255, blue: 204/255, alpha: 0.5)
            cell.accessoryType = .checkmark
        }
        return cell
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return  "АКТИВНОСТЬ"
    }
}
// MARK: - UITableViewDelegate
extension HabitDetailsViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: HabitDetailsHeader.self)) as! HabitDetailsHeader
//        return headerView
//    }
}
protocol CloseHabitDetailsViewController {
    func closeHabitDetailsViewController ()
}
extension HabitDetailsViewController: CloseHabitDetailsViewController {
    func closeHabitDetailsViewController () {
        navigationController?.popViewController(animated: false)
    }
}
