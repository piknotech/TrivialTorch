//
//  TorchError.swift
//  Trivial Torch
//
//  Created by Frederick Pietschmann on 12.02.18.
//  Copyright © 2018 piknotech. All rights reserved.
//

import Foundation

enum TorchError: Error {
    case configurationLocked
    case torchUnavailable
    case torchUninstalled
}
