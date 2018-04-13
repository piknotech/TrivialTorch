//
//  SliderDelegate.swift
//  Trivial Torch
//
//  Created by Frederick Pietschmann on 10.02.18.
//  Copyright © 2018 piknotech. All rights reserved.
//

import UIKit

protocol SliderDelegate: class {
    func sliderMoved(_ slider: Slider, to progress: Double)
}
