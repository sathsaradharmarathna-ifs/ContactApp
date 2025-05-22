//
//  NavigationManager.swift
//  Simple
//
//  Created by Sathsara Dharmarathna on 2025-05-19.
//

import UIKit

class NavigationManager {
    
    static let shared = NavigationManager()
    
    private init() {}
    
    func manageRoot(window: UIWindow?) {
        guard let window = window else { return }
        
        let rootVC: UIViewController
        let homeStoryboard = UIStoryboard(name: "Home", bundle: nil)
        rootVC = (homeStoryboard.instantiateViewController(withIdentifier: "HomeVC") as? HomeVC)!
        let nav = UINavigationController(rootViewController: rootVC)
        window.rootViewController = nav
        window.makeKeyAndVisible()
        
    }
}
