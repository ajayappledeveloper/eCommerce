//
//  AppDelegate.swift
//  eCommerce
//
//  Created by Ajay Babu Singineedi on 22/04/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let productViewModel = ProductViewModel(dataProvider: LocalDataProvider())
        let rootVC = ProductsViewController(viewModel: productViewModel)
        window?.rootViewController = UINavigationController(rootViewController: rootVC)
        configureNavBarAppearance()
        window?.makeKeyAndVisible()
        return true
    }
    
    func configureNavBarAppearance() {
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        }
    }


}

