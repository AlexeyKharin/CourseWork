//
//  InfoViewController.swift
//  Интерфейс приложения-IOS8-KharinAlexey
//
//  Created by Alexey Kharin on 27.02.2021.
//

import UIKit

class InfoViewController: UIViewController {
  
    var labelDescription: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.textColor = .black
        label.backgroundColor = .white
        label.text = """
 Прохождение этапов, за которые за 21 день вырабатывается привычка, подчиняется следующему алгоритму:
            
1. Провести 1 день без обращения к старым привычкам, стараться вести себя так, как будто цель, загаданная в перспективу, находится на расстоянии шага.

2. Выдержать 2 дня в прежнем состоянии самоконтроля.

3. Отметить в дневнике первую неделю изменений и подвести первые итоги — что оказалось тяжело, что — легче, с чем еще предстоит серьезно бороться.

4. Поздравить себя с прохождением первого серьезного порога в 21 день. За это время отказ от дурных наклонностей уже примет форму осознанного преодоления и человек сможет больше работать в сторону принятия положительных качеств.

5. Держать планку 40 дней. Практикующий методику уже чувствует себя освободившимся от прошлого негатива и двигается в нужном направлении с хорошей динамикой.

6. На 90-й день соблюдения техники все лишнее из «прошлой жизни» перестает напоминать о себе, и человек, оглянувшись назад, осознает себя полностью обновившимся.

Источник: psychbook.ru
"""
        
        label.numberOfLines = .zero
        label.toAutoLayout()
        return label
    }()
    
    var labeltitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .black
        label.text = "Привычка за 21 день"
        label.backgroundColor = .white
        label.toAutoLayout()
        return label
    }()
    
    private let containerView: UIView = {
        let containerView = UIView()
        containerView.toAutoLayout()
        return containerView
    }()
    
    private lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.toAutoLayout()
        return sv
    }()
    func setUp() {
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(labeltitle)
        containerView.addSubview(labelDescription)
        let constraints = [
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            labeltitle.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 22),
            labeltitle.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            labeltitle.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            
            labelDescription.topAnchor.constraint(equalTo: labeltitle.bottomAnchor, constant: 16),
            labelDescription.leadingAnchor.constraint(equalTo: labeltitle.leadingAnchor),
            labelDescription.trailingAnchor.constraint(equalTo: labeltitle.trailingAnchor),
            labelDescription.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16)
            
        ]
        NSLayoutConstraint.activate(constraints)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Информация"
        setUp()
        
    }
    



}
extension UIView {
    func toAutoLayout() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
