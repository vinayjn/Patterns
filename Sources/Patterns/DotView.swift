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
    private weak var hReplicator: CAReplicatorLayer!
    private weak var vReplicator: CAReplicatorLayer!
    
    public override class var layerClass: AnyClass {
        return CAReplicatorLayer.self
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self._setup()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        self._setup()
    }
    
    private func _setup() {
        let circle = CAShapeLayer()
        circle.shouldRasterize = true
        
        let horizontal = CAReplicatorLayer()
        horizontal.shouldRasterize = true
        horizontal.addSublayer(circle)
        self.pattern = circle
        
        let vertical = CAReplicatorLayer()
        vertical.addSublayer(horizontal)
        
        self.hReplicator = horizontal
        
        self.layer.insertSublayer(vertical, at: 0)
        self.vReplicator = vertical
    }
    
    private func _redraw() {
        
        let path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: dotSize, height: dotSize))
        pattern.fillColor = self.dotColor.cgColor
        pattern.path = path.cgPath
                
        let translateFactor = dotSize + spacing
        let count = Int(Double(self.bounds.width) / spacing) + 1
        let transform = CATransform3DTranslate(CATransform3DIdentity, CGFloat(translateFactor), 0, 0.0);
        hReplicator.instanceTransform = transform
        hReplicator.instanceCount = count
        let vcount = Int(Double(self.bounds.height) / spacing) + 1
        let vTransform = CATransform3DTranslate(CATransform3DIdentity, 0.0, CGFloat(translateFactor), 0.0);
        
        vReplicator.instanceCount = vcount
        vReplicator.instanceTransform = vTransform
    }
    
    public override func layoutSubviews() {
        self.vReplicator.frame = self.bounds
        self._redraw()
        super.layoutSubviews()
    }
}
