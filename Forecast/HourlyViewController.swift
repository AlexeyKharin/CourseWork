import UIKit
import Foundation
class HourlyViewController: UIViewController {
    
    var realmModelHourly: RealmModelCurrent
    
    let customNavigationBar = UINavigationBar()
    
    let customNavigationController: UINavigationController
    
    init(realmModelHourly: RealmModelCurrent, customNavigationController: UINavigationController) {
        self.realmModelHourly = realmModelHourly
        self.customNavigationController = customNavigationController
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .white
        tableView.toAutoLayout()
        tableView.separatorColor = UIColor(red: 32/255, green: 78/255, blue: 199/255, alpha: 1)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(HourlyTableViewCell.self, forCellReuseIdentifier: String(describing: HourlyTableViewCell.self))
        return tableView
    }()
    
    lazy var titleCity: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = UIColor(red: 39/255, green: 39/255, blue: 34/255, alpha: 1)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.toAutoLayout()
        return label
    }()
    
    lazy var backTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = UIColor(red: 154/255, green: 150/255, blue: 150/255, alpha: 1)
        label.text = "Прогноз на 24 часа"
        label.textAlignment = .left
        return label
    }()
    
    lazy var buttonBack: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "arrow.backward")!.applyingSymbolConfiguration(.init(scale: .large))! .withTintColor(UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1)).withRenderingMode(.alwaysOriginal), for:.normal)
        button.addTarget(self, action: #selector(back), for: .touchUpInside)
        return button
    }()
    
    @objc func back() {
        customNavigationController.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(customNavigationBar)
        customNavigationBar.addSubview(buttonBack)
        customNavigationBar.addSubview(backTitle)
        view.backgroundColor = .white
        
        customNavigationBar.frame = CGRect(
            x: .zero,
            y: 44,
            width: self.view.bounds.width,
            height: 50)
        setupViews()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        buttonBack.frame = CGRect(
            x: 16,
            y: 34,
            width: 15,
            height: 12)
        
        backTitle.frame = CGRect(
            x: buttonBack.frame.maxX + 20,
            y: 30,
            width: 200,
            height: 20)
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
// MARK: - UITableViewDataSource
extension HourlyViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return realmModelHourly.hourlyWeather.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: HourlyTableViewCell = tableView.dequeueReusableCell(
            withIdentifier: String(describing: HourlyTableViewCell.self),
            for: indexPath) as! HourlyTableViewCell
        
        cell.contentHour = realmModelHourly.hourlyWeather[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
}

// MARK: - UITableViewDelegate
extension HourlyViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .zero
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        .zero
    }
    
}

// MARK: - Setup Views
private extension HourlyViewController {
    
    func setupViews() {
        
        view.addSubview(tableView)
        view.addSubview(titleCity)
        
        let constraints = [
            
            titleCity.topAnchor.constraint(equalTo: customNavigationBar.bottomAnchor, constant: 15),
            titleCity.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 48),
            
            tableView.topAnchor.constraint(equalTo: titleCity.bottomAnchor, constant: 15),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
