//
//  AppDelegate.swift
//  SberbankConcept
//
//  Created by Кирилл Худяков on 13.09.2020.
//  Copyright © 2020 Худяков Кирилл. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        UINavigationBar.appearance().backgroundColor = .clear
        UINavigationBar.appearance().isTranslucent = true
        
        window = UIWindow()
        window?.rootViewController = UINavigationController(rootViewController: MainViewController(viewModel: MainViewModel()))
        window?.makeKeyAndVisible()
        
        return true
    }

}
