//
//  Slider.swift
//  Trivial Torch
//
//  Created by Frederick Pietschmann on 10.02.18.
//  Copyright © 2018 Piknotech. All rights reserved.
//

import UIKit

class Slider: UIView {
    // MARK: - Properties
    var stepCount: Double = 2
    var icon: UIImage?
    private var wrappedProgress: Double = 0
    var progress: Double {
        get {
            return wrappedProgress
        }

        set {
            let oldValue = progress
            wrappedProgress = ((stepCount - 1) * newValue).rounded() / (stepCount - 1)
            if wrappedProgress != oldValue {
                layout()
            }
        }
    }

    private var backgroundLayer: CAShapeLayer
    private var iconImageView: UIImageView
    private var shouldTrackTouchMovements = false
    private var dotWidth: CGFloat {
        return 0.8 * bounds.width
    }

    weak var delegate: SliderDelegate?

    // MARK: - Initializers
    required init?(coder aDecoder: NSCoder) {
        backgroundLayer = CAShapeLayer()
        iconImageView = UIImageView()

        super.init(coder: aDecoder)

        backgroundColor = .clear
        isMultipleTouchEnabled = false

        backgroundLayer.fillColor = UIColor.white.cgColor
        backgroundLayer.opacity = 0.4
        layer.addSublayer(backgroundLayer)

        iconImageView.tintColor = UIColor.white.withAlphaComponent(0.6)
        addSubview(iconImageView)
    }

    // MARK: - Methods: Layout
    override func layoutSubviews() {
        super.layoutSubviews()

        layout()
        shouldTrackTouchMovements = false
    }

    func layout() {
        let cornerRadius = bounds.width / 2

        // Layout icon
        iconImageView.frame.size = CGSize(width: dotWidth, height: dotWidth)
        iconImageView.image = icon?.withRenderingMode(.alwaysTemplate)
        let distance = (bounds.width - dotWidth) / 2
        iconImageView.frame.origin = CGPoint(
            x: distance,
            y: distance + (1 - CGFloat(progress)) * (bounds.height - dotWidth - 2 * distance)
        )

        // Layout path
        let path = UIBezierPath(
            roundedRect: CGRect(origin: .zero, size: bounds.size),
            cornerRadius: cornerRadius
        )
        let circleCutoutPath = UIBezierPath(ovalIn: iconImageView.frame)
        path.append(circleCutoutPath.reversing())
        backgroundLayer.path = path.cgPath
    }

    // MARK: Touch Handling
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)

        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let dotCenter = iconImageView.center
        let radius = dotWidth / 2
        let centerDistance = sqrt(pow(location.y - dotCenter.y, 2) + pow(location.x - dotCenter.x, 2))

        // Only track touch movement if touch is within dot
        shouldTrackTouchMovements = centerDistance < radius
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)

        guard let touch = touches.first, shouldTrackTouchMovements else { return }
        let dotYCenter = touch.location(in: self).y

        let upperBound = (bounds.width - dotWidth) / 2 + dotWidth / 2
        let lowerBound = bounds.height - upperBound
        progress = Double(min(1, max(0, 1 - (dotYCenter - upperBound) / (lowerBound - upperBound))))
        delegate?.sliderMoved(self, to: progress)
    }
}
