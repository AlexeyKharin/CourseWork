import UIKit

class PageViewController: UIPageViewController {
    
    var pages = [UIViewController]()
    
    let pageControl = UIPageControl()
    
    let initialPage = 0
    
    let customNavigationBar = UINavigationBar()
    
    lazy var buttonSettings: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "settings")!.applyingSymbolConfiguration(.init(scale: .large))! .withTintColor(UIColor(red: 39/255, green: 39/255, blue: 39/255, alpha: 1)).withRenderingMode(.alwaysOriginal), for:.normal)
        return button
    }()
    
    lazy var buttonFindLocation: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "location")!.applyingSymbolConfiguration(.init(scale: .large))! .withTintColor(UIColor(red: 39/255, green: 39/255, blue: 39/255, alpha: 1)).withRenderingMode(.alwaysOriginal), for:.normal)
        return button
    }()

   
    override func viewDidLoad() {
        super.viewDidLoad()
    
        view.addSubview(customNavigationBar)
        customNavigationBar.backgroundColor = .white
        customNavigationBar.addSubview(buttonSettings)
        customNavigationBar.addSubview(buttonFindLocation)
        
        customNavigationBar.frame = CGRect(
            x: .zero,
            y: 44,
            width: self.view.bounds.width,
            height: 50)
        
        setup()
        style()
        layout()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    
        buttonSettings.frame = CGRect(
            x: 16,
            y: 10,
            width: 20,
            height: 32)
        
        buttonFindLocation.frame = CGRect(
            x: view.bounds.width - 41,
            y: 10,
            width: 25,
            height: 32)
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

extension PageViewController {
    
    func createOneViewCintroller(page: UIViewController) {
        pages.append(page)
        pageControl.numberOfPages = pages.count
        setViewControllers([pages[initialPage]], direction: .forward, animated: true, completion: nil)
    }
    
    func createBasedViewControllers(pages: [UIViewController]) {
        self.pages = pages
        self.pageControl.numberOfPages = self.pages.count
        setViewControllers([self.pages[initialPage]], direction: .forward, animated: true, completion: nil)
    }
    
    func setup() {
        dataSource = self
        delegate = self
        
        pageControl.addTarget(self, action: #selector(pageControlTapped(_:)), for: .valueChanged)
    }
    
    func style() {
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.pageIndicatorTintColor = .systemGray2
        pageControl.currentPage = initialPage
        
    }
    
    func layout() {
        view.addSubview(pageControl)
        
        NSLayoutConstraint.activate([
            pageControl.topAnchor.constraint(equalTo: customNavigationBar.bottomAnchor),
            pageControl.widthAnchor.constraint(equalTo: view.widthAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: 20)
          
        ])
    }
    
    @objc func pageControlTapped(_ sender: UIPageControl) {
        setViewControllers([pages[sender.currentPage]], direction: .forward, animated: true, completion: nil)
    }
}

// MARK: - DataSource
extension PageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
        
        if currentIndex == 0 {
            return pages.last               // wrap last
        } else {
            return pages[currentIndex - 1]  // go previous
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
        
        if currentIndex < pages.count - 1 {
            return pages[currentIndex + 1]  // go next
        } else {
            return pages.first              // wrap first
        }
    }
}

// MARK: - Delegates
extension PageViewController: UIPageViewControllerDelegate {
    
    // How we keep our pageControl in sync with viewControllers
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        guard let viewControllers = pageViewController.viewControllers else { return }
        guard let currentIndex = pages.firstIndex(of: viewControllers[0]) else { return }
        
        pageControl.currentPage = currentIndex
    }
}


