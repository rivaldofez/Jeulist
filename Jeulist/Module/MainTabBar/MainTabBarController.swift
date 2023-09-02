//
//  MainTabBarController.swift
//  Jeulist
//
//  Created by Rivaldo Fernandes on 31/08/23.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabs()
    }
    
    private func setupTabs() {
        let homeRouter = HomeRouter.start()
        guard let homeVC = homeRouter.begin else { return }
        
        let homeNavItem = self.createNav(with: "Home", and: UIImage(systemName: "list.bullet.below.rectangle"), vc: homeVC)
        
        let favoriteGameRouter = FavoriteGameRouter.createFavoriteGame()
        guard let favoriteVC = favoriteGameRouter.entry else { return }
        let favoriteNavItem = self.createNav(with: "Favorite", and: UIImage(systemName: "heart"), vc: favoriteVC)
        
        
        let profileVC = ProfileViewController()
        let profileNavItem = self.createNav(with: "Profile", and: UIImage(systemName: "person"), vc: profileVC)
        
        self.setViewControllers([homeNavItem, favoriteNavItem, profileNavItem], animated: true)
    }
    
    private func createNav(with title: String, and image: UIImage?, vc: UIViewController) -> UINavigationController {
        
        let nav = UINavigationController(rootViewController: vc)
        
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        
        return nav
    }
}
