//
//  ScreenshotManager.swift
//  Trivial Torch
//
//  Created by Frederick Pietschmann on 15.04.18.
//  Copyright © 2018 Piknotech. All rights reserved.
//

import UIKit

final class ScreenshotManager {
    // MARK: - Subtypes
    struct Configuration {
        var brightness: Double
        var strobe: Double
    }

    // MARK: - Properties
    static let shared = ScreenshotManager()
    private let configurations: [Configuration] = [
        Configuration(brightness: 0, strobe: 0),
        Configuration(brightness: 1, strobe: 0),
        Configuration(brightness: 0.8, strobe: 0.5)
    ]
    private var currentConfigIndex = 0

    // MARK: - Initializers
    private init() { }

    // MARK: - Methods
    /// Main start point. To be called in AppDelegate.
    func takeover() {
        let mainVc = MainViewController.shared

        // Create overlay view and add gesture recognizer.
        // This automatically disables other user interaction
        let view = UIView(frame: mainVc.view.bounds)
        view.backgroundColor = UIColor.white.withAlphaComponent(0) // Required for tap gesture recognizer
        UIApplication.shared.delegate!.window!!.addSubview(view)

        let recognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(screenTapped(sender:))
        )
        view.addGestureRecognizer(recognizer)

        // Setup for first configuration
        setup(for: configurations.first!)
    }

    // MARK: Top Handling
    /// Navigates between screenshots when the screen is tapped.
    @objc
    private func screenTapped(sender: UITapGestureRecognizer) {
        let isOnLeftHalf = sender.location(in: MainViewController.shared.view).x < MainViewController.shared.view.bounds.width / 2

        if isOnLeftHalf {
            currentConfigIndex = max(currentConfigIndex - 1, 0)
        } else {
            currentConfigIndex = min(currentConfigIndex + 1, configurations.count - 1)
        }

        // Setup for next configuration
        setup(for: configurations[currentConfigIndex])
    }

    /// Sets up the view for the given configuration.
    private func setup(for configuration: Configuration) {
        let mainVc = MainViewController.shared
        mainVc.set(brightness: configuration.brightness, strobe: configuration.strobe)
        mainVc.setBrightness(configuration.strobe == 0 ? configuration.brightness : 0)
        mainVc.setTorchSettingError(nil)
    }
}
