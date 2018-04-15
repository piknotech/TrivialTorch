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
    weak var delegate: SliderDelegate?
    var stepCount: Double = 2
    var progress: Double {
        get {
            return wrappedProgress
        }

        set {
            let oldValue = progress
            wrappedProgress = ((stepCount - 1) * newValue).rounded() / (stepCount - 1)
            if wrappedProgress != oldValue {
                layout(animated: true)
            }
        }
    }

    var icon: UIImage? {
        didSet {
            iconImageView.image = icon?.withRenderingMode(.alwaysTemplate)
        }
    }

    private var wrappedProgress: Double = 0
    private var backgroundLayer: CAShapeLayer
    private var iconImageView: UIImageView
    private var shouldTrackTouchMovements = false
    private var iconWidth: CGFloat {
        return 0.8 * bounds.width
    }

    // MARK: - Initializers
    required init?(coder aDecoder: NSCoder) {
        backgroundLayer = CAShapeLayer()
        iconImageView = UIImageView()

        super.init(coder: aDecoder)

        backgroundColor = .clear
        alpha = 0.4
        isMultipleTouchEnabled = false

        iconImageView.tintColor = .white
        addSubview(iconImageView)
        backgroundLayer.fillColor = UIColor.white.cgColor
        layer.addSublayer(backgroundLayer)
    }

    // MARK: - Methods: Layout
    override func layoutSubviews() {
        super.layoutSubviews()

        layout()
        shouldTrackTouchMovements = false
    }

    func layout(animated: Bool = false) {
        // Define constants
        let cornerRadius = bounds.width / 2
        let animationTime = 0.3

        // Calculate new icon frame
        let distance = (bounds.width - iconWidth) / 2
        let newIconImageViewOrigin = CGPoint(
            x: distance,
            y: distance + (1 - CGFloat(progress)) * (bounds.height - iconWidth - 2 * distance)
        )
        let newIconImageViewBounds = CGRect(
            x: 0,
            y: 0,
            width: iconWidth,
            height: iconWidth
        )
        let newIconImageViewFrame = CGRect(
            origin: newIconImageViewOrigin,
            size: newIconImageViewBounds.size
        )

        // Calculate new path
        let newPath = UIBezierPath(
            roundedRect: CGRect(origin: .zero, size: bounds.size),
            cornerRadius: cornerRadius
        )
        let circleCutoutPath = UIBezierPath(ovalIn: newIconImageViewFrame)
        newPath.append(circleCutoutPath.reversing())

        // Animate
        if animated {
            CATransaction.begin()
            CATransaction.setDisableActions(true)

            iconImageView.layer.bounds = newIconImageViewBounds
            iconImageView.layer.position = newIconImageViewOrigin
            let boundsAnimation = CABasicAnimation(keyPath: "bounds")
            boundsAnimation.duration = animationTime
            let positionAnimation = CABasicAnimation(keyPath: "position")
            positionAnimation.duration = animationTime
            boundsAnimation.timingFunction = CAMediaTimingFunction(name: "linear")
            positionAnimation.timingFunction = CAMediaTimingFunction(name: "linear")
            iconImageView.layer.add(boundsAnimation, forKey: nil)
            iconImageView.layer.add(positionAnimation, forKey: nil)

            let pathAnimation = CABasicAnimation(keyPath: "path")
            pathAnimation.fromValue = backgroundLayer.path
            pathAnimation.toValue = newPath
            pathAnimation.duration = animationTime
            pathAnimation.timingFunction = CAMediaTimingFunction(name: "linear")
            backgroundLayer.add(pathAnimation, forKey: "path")
            backgroundLayer.path = newPath.cgPath

             CATransaction.commit()
        } else {
            backgroundLayer.path = newPath.cgPath
            iconImageView.frame = newIconImageViewFrame
        }
    }

    // MARK: Touch Handling
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)

        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let iconCenter = iconImageView.center
        let radius = iconWidth / 2
        let centerDistance = sqrt(pow(location.y - iconCenter.y, 2) + pow(location.x - iconCenter.x, 2))

        // Only track touch movement if touch is within cutout
        shouldTrackTouchMovements = centerDistance < radius
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)

        guard let touch = touches.first, shouldTrackTouchMovements else { return }
        let iconYCenter = touch.location(in: self).y

        let upperBound = (bounds.width - iconWidth) / 2 + iconWidth / 2
        let lowerBound = bounds.height - upperBound
        progress = Double(min(1, max(0, 1 - (iconYCenter - upperBound) / (lowerBound - upperBound))))
        delegate?.sliderMoved(self, to: progress)
    }
}
