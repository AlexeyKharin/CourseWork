
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
    
    let navigation: UINavigationController
    
    init(navigation: UINavigationController) {
        self.navigation = navigation
        
        pageViewController = PageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    
//        pageViewController.clousureRreturnBack = { [weak self] (text, currentIndex) in
//         
//            let page =  self?.pageViewController.pages[currentIndex]
//        }
//        
        pageOneBoarding = OnboardingViewController()
        
        viewControllers.append(pageOneBoarding)
        
        if !realmOfFactory.realm.obtainModelCurrent().isEmpty {
            for model in realmOfFactory.realm.obtainModelCurrent() {
                
                let page = ViewControllerCoordinator(navigationController: navigation, controllerFactory: factory, nameCity: model.nameCity, id: model.id)
                
                viewControllers.append(page.page)
                
                coordinators.append(page)
            }
            pageViewController.createBasedViewControllers(pages: viewControllers)
        } else {
            pageViewController.createBasedViewControllers(pages: viewControllers)
        }
        
        pageOneBoarding.transferString = { text in
            let page = ViewControllerCoordinator(navigationController: navigation, controllerFactory: self.factory as ControllerFactory, nameCity: text, id: String(describing: (self.viewControllers.count) + 1))
            
            self.pageViewController.createOneViewCintroller(page: page.page)
            self.viewControllers.append(page.page)
            self.coordinators.append(page)
        }
    }
}
