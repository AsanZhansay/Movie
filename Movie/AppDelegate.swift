//
//  AppDelegate.swift
//  Movie
//
//  Created by Asanali Zhansay on 07.02.2022.
//

import UIKit
import SnapKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        setRootViewController()
        
        return true
    }

    private func setRootViewController() {
        let vc = SearchVC()
        let navC = UINavigationController(rootViewController: vc)
        window?.rootViewController = navC
    }
}

