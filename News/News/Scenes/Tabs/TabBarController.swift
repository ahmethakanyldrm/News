//
//  TabBarController.swift
//  News
//
//  Created by AHMET HAKAN YILDIRIM on 29.06.2025.
//

import UIKit

class TabBarController: UITabBarController {

    // MARK: - Properties
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
    }

}

// MARK: - Extension

private extension TabBarController {
    func setupTabs() {
        let homeVC = createNav(with: "News", and: UIImage(systemName: "newspaper.fill"), viewController: NewsViewController())
        let settingsVC = createNav(with: "Settings", and: UIImage(systemName: "gearshape"), viewController: SettingsViewController())
        
        setViewControllers([homeVC, settingsVC], animated: true)
        
    }
    
    func createNav(
        with title: String,
        and image: UIImage?,
        viewController: UIViewController
    ) -> UINavigationController {
        
        let nav = UINavigationController(
            rootViewController: viewController
        )
            nav.tabBarItem.title = title
            nav.tabBarItem.image = image
            viewController.title = title
            nav.navigationBar.prefersLargeTitles = true
            viewController.navigationItem.largeTitleDisplayMode = .always
            return nav
    }
}
