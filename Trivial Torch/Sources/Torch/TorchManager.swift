//
//  TorchManager.swift
//  Trivial Torch
//
//  Created by Frederick Pietschmann on 10.02.18.
//  Copyright © 2018 Frederick Pietschmann. All rights reserved.
//

import UIKit

class TorchManager {
    // MARK: - Properties
    static let shared = TorchManager()
    weak var delegate: TorchManagerDelegate?
    var brightness: Double = 0
    var strobeLevel: Double = 0

    private var activeTimer: Timer?
    private var currentBrightness: Double?
    private var currentTorchMode: TorchMode {
        return TorchMode(brightness: brightness, strobeLevel: strobeLevel)
    }

    // MARK: - Methods
    func start() {
        update()
    }

    func stop() {
        activeTimer?.invalidate()
        activeTimer = nil
        delegate?.setBrightness(0)
        currentBrightness = 0
    }

    func manageUpdate() {
        if activeTimer == nil {
            // Timer doesn't manage update, so do manually
            update()
        }
    }

    private func update() {
        switch currentTorchMode {
        case .permanent(let brightness):
            setBrightness(brightness)
            activeTimer = nil

        case .strobe(let brightness, let interval):
            setBrightness(currentBrightness == 0 ? brightness : 0)
            activeTimer = Timer.scheduledTimer(withTimeInterval: interval, repeats: false) { [unowned self] _ in
                self.update()
            }
        }
    }

    private func setBrightness(_ brightness: Double) {
        guard brightness != currentBrightness else { return }
        currentBrightness = brightness
        var torchSettingError: TorchError?
        do {
            try Torch.shared.setBrightness(brightness)
        } catch let error {
            torchSettingError = error as? TorchError
        }

        delegate?.setBrightness(brightness)
        delegate?.setTorchSettingError(torchSettingError)
    }
}
