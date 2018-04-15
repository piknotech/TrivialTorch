//
//  Torch.swift
//  Trivial Torch
//
//  Created by Frederick Pietschmann on 12.02.18.
//  Copyright © 2018 Piknotech. All rights reserved.
//

import AVFoundation
import Foundation

class Torch {
    // MARK: - Properties
    static let shared = Torch()
    private var device: AVCaptureDevice?

    // MARK: - Initializers
    init() {
        let device = AVCaptureDevice.default(for: .video)
        if device?.hasTorch == true {
            self.device = device
        }
    }

    // MARK: - Methods
    func setBrightness(_ brightness: Double) throws {
        guard let device = device else { throw TorchError.torchUninstalled }
        guard device.isTorchAvailable else { throw TorchError.torchUnavailable }

        do {
            try device.lockForConfiguration()
        } catch {
            throw TorchError.configurationLocked
        }

        defer { device.unlockForConfiguration() }

        if brightness == 0 {
            device.torchMode = .off
        } else {
            try? device.setTorchModeOn(level: Float(brightness))
        }
    }
}
