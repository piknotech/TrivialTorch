//
//  TorchMode.swift
//  Trivial Torch
//
//  Created by Frederick Pietschmann on 12.02.18.
//  Copyright © 2018 Frederick Pietschmann. All rights reserved.
//

import Foundation

enum TorchMode {
    case permanent(brightness: Double)
    case strobe(brightness: Double, interval: Double)

    init(brightness: Double, strobeLevel: Double) {
        if strobeLevel == 0 || brightness == 0 {
            self = .permanent(brightness: brightness)
        } else {
            let interval = exp(-3.5 * sqrt(strobeLevel))
            self = .strobe(brightness: brightness, interval: interval)
        }
    }
}
