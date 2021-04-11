


import   UIKit
class HabitCollectionViewCell:  UICollectionViewCell {
    
    var changeDelegate: ReloadData?
    
    var countHabits: Int? {
        didSet {
            guard let count =  countHabits else { return }
            countPickedHabit.text = "Подряд: \(count) "
        }
    }
    var informationOfHabit: Habit? {
        didSet {
            nameHabit.text = informationOfHabit?.name
            nameHabit.textColor = informationOfHabit?.color
            buttonTrack.layer.borderColor = informationOfHabit?.color.cgColor
            timeForHabit.text = " Каждый день в \(dateFormatter.string(from: informationOfHabit!.date))"
            print("Данные подгружены")
        }
    }
    
    let nameHabit: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.toAutoLayout()
        label.backgroundColor = .white
        return label
    }()
    
    let countPickedHabit: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.textColor = .systemGray
        label.textAlignment = .left
        label.toAutoLayout()
        label.backgroundColor = .white
        return label
    }()
    
    lazy var buttonTrack: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 19
        button.layer.borderWidth = 2
        button.addTarget(self, action: #selector(track), for: .touchUpInside)
        button.toAutoLayout()
        return button
    }()
    
    var switcher: Bool? {
        didSet {
            if switcher! {
                buttonTrack.backgroundColor = informationOfHabit?.color
                buttonTrack.setImage(UIImage(systemName: "checkmark")?.applyingSymbolConfiguration(.init(scale: .large))! .withTintColor(.white).withRenderingMode(.alwaysOriginal), for:.normal)
            } else {
                buttonTrack.backgroundColor = .white
                buttonTrack.setImage(UIImage(systemName: ""), for: .normal)
            }
        }
    }
    
    @objc func track() {
        HabitsStore.shared.track(informationOfHabit!)
        changeDelegate?.didChangeHabits()
    }
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.timeStyle = .short
        return formatter
    }()
    
    let timeForHabit: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.toAutoLayout()
        label.textColor = .systemGray2
        label.backgroundColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 8
        clipsToBounds = true
        backgroundColor = .white
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        contentView.addSubview(nameHabit)
        contentView.addSubview(timeForHabit)
        contentView.addSubview(buttonTrack)
        contentView.addSubview(countPickedHabit)
        
        let constraints = [
            nameHabit.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            nameHabit.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            nameHabit.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -82),
            
            timeForHabit.topAnchor.constraint(equalTo: nameHabit.bottomAnchor, constant: 4),
            timeForHabit.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            buttonTrack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 47),
            buttonTrack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -26),
            buttonTrack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -47),
            buttonTrack.heightAnchor.constraint(equalToConstant: 36),
            buttonTrack.widthAnchor.constraint(equalToConstant: 36),
            
            countPickedHabit.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            countPickedHabit.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
