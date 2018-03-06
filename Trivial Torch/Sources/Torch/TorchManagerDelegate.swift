//
//  TorchManagerDelegate.swift
//  Trivial Torch
//
//  Created by Frederick Pietschmann on 11.02.18.
//  Copyright © 2018 Frederick Pietschmann. All rights reserved.
//

import Foundation

protocol TorchManagerDelegate: class {
    func setBrightness(_ brightness: Double)
    func setTorchSettingError(_ torchSettingError: TorchError?)
}
