//
//  DotView.swift
//  Test
//
//  Created by Vinay Jain on 05/05/20.
//  Copyright © 2020 Vinay Jain. All rights reserved.
//

import UIKit

@IBDesignable public class DotView: UIView {
    
    @IBInspectable public var dotColor: UIColor! = .white {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable public var spacing: Double = 4 {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable public var dotSize: Double = 4 {
        didSet {
            self.setNeedsLayout()
        }
    }
    private var pattern: CAShapeLayer!
    
    public override class var layerClass: AnyClass {
        return CAReplicatorLayer.self
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        _setup()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        _setup()
    }
    
    private func _redraw() {
        for layer in self.layer.sublayers ?? [] {
            layer.removeFromSuperlayer()
        }
        let path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: dotSize, height: dotSize))
        pattern.fillColor = self.dotColor.cgColor
        pattern.path = path.cgPath
        
        let horizontal = CAReplicatorLayer()
        horizontal.shouldRasterize = true
        horizontal.addSublayer(pattern)
        let translateFactor = dotSize + spacing
        let count = Int(Double(self.bounds.width) / spacing) + 1
        let transform = CATransform3DTranslate(CATransform3DIdentity, CGFloat(translateFactor), 0, 0.0);
        horizontal.instanceTransform = transform
        horizontal.instanceCount = count
        let vcount = Int(Double(self.bounds.height) / spacing) + 1
        let vTransform = CATransform3DTranslate(CATransform3DIdentity, 0.0, CGFloat(translateFactor), 0.0);
        
        (self.layer as? CAReplicatorLayer)?.instanceCount = vcount
        (self.layer as? CAReplicatorLayer)?.instanceTransform = vTransform
        self.layer.addSublayer(horizontal)
        
    }
    
    private func _setup() {
        let circle = CAShapeLayer()
        circle.shouldRasterize = true
        pattern = circle
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        self._redraw()
    }
}
