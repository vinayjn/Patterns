//
//  DotView.swift
//  Test
//
//  Created by Vinay Jain on 05/05/20.
//  Copyright © 2020 Vinay Jain. All rights reserved.
//

import UIKit

@IBDesignable class DotView: UIView {
    
    @IBInspectable var dotColor: UIColor! = .white {
        didSet {
            self.pattern.fillColor = dotColor.cgColor
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable var spacing: Double = 4 {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable var dotSize: Double = 4 {
        didSet {
            self.setNeedsDisplay()
        }
    }
    private var pattern: CAShapeLayer!
    
    override class var layerClass: AnyClass {
        return CAReplicatorLayer.self
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        _setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        _setup()
    }
    
    private func _redraw() {
        for layer in self.layer.sublayers ?? [] {
            layer.removeFromSuperlayer()
        }
        let horizontal = CAReplicatorLayer()
        horizontal.addSublayer(pattern)
        let translateFactor = spacing
        let count = Int(Double(self.bounds.width) / spacing) + 1
        let transform = CATransform3DTranslate(CATransform3DIdentity, CGFloat(translateFactor), 0, 1.0);
        horizontal.instanceTransform = transform
        horizontal.instanceCount = count
        let vcount = Int(Double(self.bounds.height) / spacing) + 1
        let vTransform = CATransform3DTranslate(CATransform3DIdentity, 0.0, CGFloat(translateFactor), 1.0);
        
        (self.layer as? CAReplicatorLayer)?.instanceCount = vcount
        (self.layer as? CAReplicatorLayer)?.instanceTransform = vTransform
        self.layer.addSublayer(horizontal)
    }
    
    private func _setup() {
        let circle = CAShapeLayer()
        let path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: dotSize, height: dotSize))
        circle.fillColor = self.dotColor.cgColor
        circle.path = path.cgPath
        pattern = circle
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self._redraw()
    }
}
