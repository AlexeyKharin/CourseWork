import Foundation
import  UIKit

class ContainerCoordinator {
    
    let containerViewController: ContainerViewController
    let pageController: PageViewController
    let menuViewController: UIViewController
    let navigation: UINavigationController
    
    init(navigation: UINavigationController) {
        self.navigation = navigation
        pageController = PageCoordinator(navigation: navigation).pageViewController
        menuViewController = MenuViewController(navigation: navigation)
        pageController.dataTransfer = menuViewController as? DataTranfer
        containerViewController = ContainerViewController(pageController: pageController, menuViewController: menuViewController as! MenuViewController)
}
}
