//
//  MainViewController.swift
//  Trivial Torch
//
//  Created by Frederick Pietschmann on 10.02.18.
//  Copyright © 2018 Frederick Pietschmann. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    // MARK: - Properties
    static var shared: MainViewController!
    override var prefersStatusBarHidden: Bool { return true }

    @IBOutlet private var brightnessSlider: Slider!
    @IBOutlet private var strobeSlider: Slider!
    @IBOutlet private var torchView: UIView!
    @IBOutlet private var errorLabel: UILabel!

    // MARK: - Initializers
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        TorchManager.shared.delegate = self
    }

    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        brightnessSlider.dotMask = #imageLiteral(resourceName: "brightnessMask")
        brightnessSlider.stepCount = 10
        brightnessSlider.delegate = self

        strobeSlider.dotMask = #imageLiteral(resourceName: "strobeMask")
        strobeSlider.stepCount = 20
        strobeSlider.delegate = self
    }

    func set(brightness: Double, strobe: Double) {
        brightnessSlider.progress = brightness
        strobeSlider.progress = strobe
        TorchManager.shared.brightness = brightness
        TorchManager.shared.strobeLevel = strobe
    }
}

// MARK: - TorchManagerDelegate
extension MainViewController: TorchManagerDelegate {
    func setBrightness(_ brightness: Double) {
        torchView.alpha = CGFloat(0.5 * brightness)
    }

    func setTorchSettingError(_ torchSettingError: TorchError?) {
        switch torchSettingError {
        case .some(.configurationLocked):
            errorLabel.text = "Error accessing flashlight."

        case .some(.torchUnavailable):
            errorLabel.text = "Flashlight currently unavailable."

        case .some(.torchUninstalled):
            errorLabel.text = "No flashlight installed."

        case .none:
            errorLabel.text = ""
        }
    }
}

// MARK: - SliderDelegate
extension MainViewController: SliderDelegate {
    func sliderMoved(_ slider: Slider, to progress: Double) {
        if slider == brightnessSlider {
            // Handle brightness change
            TorchManager.shared.brightness = progress
            TorchManager.shared.manageUpdate()
        } else if slider == strobeSlider {
            // Handle strobe change
            TorchManager.shared.strobeLevel = progress
            TorchManager.shared.manageUpdate()
        }
    }
}
