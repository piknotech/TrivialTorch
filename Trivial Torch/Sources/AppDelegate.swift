//
//  AppDelegate.swift
//  Trivial Torch
//
//  Created by Frederick Pietschmann on 10.02.18.
//  Copyright © 2018 Frederick Pietschmann. All rights reserved.
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
        guard let mainVc = UIStoryboard(
            name: "Main",
            bundle: nil
        ).instantiateInitialViewController() as? MainViewController else {
            fatalError("Unable to fetch initial vc")
        }

        MainViewController.shared = mainVc
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = MainViewController.shared
        window?.makeKeyAndVisible()

        // Start torch
        TorchManager.shared.start()

        // Request review
        AppReviewManager.shared.request()

        return true
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        TorchManager.shared.start()
    }

    func applicationWillResignActive(_ application: UIApplication) {
        TorchManager.shared.stop()
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        AppReviewManager.shared.request()
    }

    // MARK: 3D Touch Quick Actions
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        switch shortcutItem.type {
        case "de.fredpi.trivialtorch.torch":
            MainViewController.shared.set(brightness: 1, strobe: 0)

        case "de.fredpi.trivialtorch.mediumstrobe":
            MainViewController.shared.set(brightness: 1, strobe: 0.5)

        case "de.fredpi.trivialtorch.faststrobe":
            MainViewController.shared.set(brightness: 1, strobe: 1)

        default:
            break
        }
    }
}
