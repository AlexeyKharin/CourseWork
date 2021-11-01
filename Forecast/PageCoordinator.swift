
import Foundation
import UIKit

class PageCoordinator: Coordinator {
    
    private let factory = ViewModalFactory()
    
    private lazy var realmOfFactory = {
        factory.makeViewModal()
    }()
    
    var coordinators: [Coordinator] = []
    
    var viewControllers: [UIViewController] = []
    
    let pageViewController: PageViewController
    
    let pageOneBoarding: OnboardingViewController
    
    init() {
        pageViewController = PageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        
        
        pageOneBoarding = OnboardingViewController()
        
        viewControllers.append(pageOneBoarding)
        
        if !realmOfFactory.realm.obtainModelCurrent().isEmpty {
            for model in realmOfFactory.realm.obtainModelCurrent() {
                
                let page = ViewControllerCoordinator(navigationController: UINavigationController(), controllerFactory: factory, nameCity: model.nameCity, id: model.id)
                
                viewControllers.append(page.navigationController)
                
                coordinators.append(page)
            }
            pageViewController.createBasedViewControllers(pages: viewControllers)
        } else {
            pageViewController.createBasedViewControllers(pages: viewControllers)
        }
        
        pageOneBoarding.transferString = { [weak self] text in
            let page = ViewControllerCoordinator(navigationController: UINavigationController(), controllerFactory: self?.factory as! ControllerFactory, nameCity: text, id: String(describing: (self?.viewControllers.count)! + 1))
            
            self?.pageViewController.createOneViewCintroller(page: page.navigationController)
            self?.viewControllers.append(page.navigationController)
            self?.coordinators.append(page)
            
        }
        
    }
}
