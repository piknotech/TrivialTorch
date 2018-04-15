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
    var dotMask: UIImage?
    private var wrappedProgress: Double = 0
    var progress: Double {
        get {
            return wrappedProgress
        }

        set {
            let oldValue = progress
            wrappedProgress = ((stepCount - 1) * newValue).rounded() / (stepCount - 1)
            if wrappedProgress != oldValue {
                updateDotViewOrigin(animated: true)
            }
        }
    }

    private var backgroundLayer: CAShapeLayer
    private var dot: UIImageView
    private var shouldTrackTouchMovements = false
    private var dotWidth: CGFloat {
        return 0.8 * bounds.width
    }

    weak var delegate: SliderDelegate?

    // MARK: - Initializers
    required init?(coder aDecoder: NSCoder) {
        backgroundLayer = CAShapeLayer()
        dot = UIImageView()

        super.init(coder: aDecoder)

        backgroundColor = .clear
        isMultipleTouchEnabled = false

        backgroundLayer.strokeColor = UIColor.white.cgColor
        backgroundLayer.fillColor = UIColor.white.cgColor
        backgroundLayer.opacity = 0.4
        layer.addSublayer(backgroundLayer)

        dot.tintColor = UIColor.white.withAlphaComponent(0.6)
        addSubview(dot)
    }

    // MARK: - Methods: Layout
    override func layoutSubviews() {
        super.layoutSubviews()

        layout()
        shouldTrackTouchMovements = false
    }

    func layout() {
        layoutPath()
        layoutDotView()
    }

    func layoutPath() {
        let cornerRadius = bounds.width / 2
        let path = UIBezierPath(
            roundedRect: CGRect(
                x: 0,
                y: 0,
                width: bounds.width,
                height: bounds.height
            ),
            cornerRadius: cornerRadius
        )

        path.append(path.reversing())

        backgroundLayer.path = path.cgPath
    }

    func layoutDotView() {
        dot.frame.size = CGSize(width: dotWidth, height: dotWidth)
        updateDotViewOrigin()
        dot.image = UIGraphicsImageRenderer(bounds: dot.bounds).image { _ in
            dotMask?.draw(in: dot.bounds)
        }.withRenderingMode(.alwaysTemplate)
    }

    func updateDotViewOrigin(animated: Bool = false) {
        let update = { [unowned self] in
            let distance = (self.bounds.width - self.dotWidth) / 2
            self.dot.frame.origin = CGPoint(
                x: distance,
                y: distance + (1 - CGFloat(self.progress)) * (self.bounds.height - self.dotWidth - 2 * distance)
            )
        }

        if animated {
            UIView.animate(withDuration: 0.15, animations: update)
        } else {
            update()
        }
    }

    // MARK: TouchHandling
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)

        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let dotCenter = dot.center
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
