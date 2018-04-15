//
//  AppDelegate.swift
//  Trivial Torch
//
//  Created by Frederick Pietschmann on 10.02.18.
//  Copyright © 2018 Piknotech. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    // MARK: - Properties
    var window: UIWindow?

    // MARK: - Methods
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Do configuration
        InstallationManager.shared.store()

        // Load view controller
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = MainViewController.shared
        window?.makeKeyAndVisible()

        // Start torch
        TorchManager.shared.start()

        // Request review
        AppReviewManager.shared.request()

        // Enter screenshot creation mode
        // ScreenshotManager.shared.takeover()

        return true
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        TorchManager.shared.start()
    }

    func applicationWillResignActive(_ application: UIApplication) {
        MainViewController.shared.turnScreenOn()
        TorchManager.shared.stop()
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        AppReviewManager.shared.request()
    }

    // MARK: 3D Touch Quick Actions
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        switch shortcutItem.type {
        case "com.piknotech.trivialtorch.torch":
            MainViewController.shared.set(brightness: 1, strobe: 0)

        case "com.piknotech.trivialtorch.mediumstrobe":
            MainViewController.shared.set(brightness: 1, strobe: 0.5)

        case "com.piknotech.trivialtorch.faststrobe":
            MainViewController.shared.set(brightness: 1, strobe: 1)

        default:
            break
        }
    }
}
