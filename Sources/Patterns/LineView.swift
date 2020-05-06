//
//  LineView.swift
//  Test
//
//  Created by Vinay Jain on 05/05/20.
//  Copyright © 2020 Vinay Jain. All rights reserved.
//

import UIKit

@IBDesignable public class LineView: UIView {
    
    @IBInspectable public var lineColor: UIColor! = .white {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable public var spacing: Double = 32 {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable public var lineWidth: CGFloat = 1 {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable public var isVertical: Bool = false {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    private var pattern: CAShapeLayer!
    
    public override class var layerClass: AnyClass {
        return CAReplicatorLayer.self
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func _redraw() {
        for layer in self.layer.sublayers ?? [] {
            layer.removeFromSuperlayer()
        }
        
        let line = CAShapeLayer()
        line.strokeColor = self.lineColor.cgColor
        line.lineWidth = self.lineWidth
        let path = UIBezierPath()
        let count: Int
        let transform: CATransform3D
        let transformFactor = spacing + Double(lineWidth)
        if isVertical {
            path.move(to: .init(x: lineWidth/2.0, y: 0))
            path.addLine(to: .init(x: lineWidth/2.0, y: self.bounds.maxY))
            count = Int(Double(self.bounds.width) / transformFactor) + 1
            transform = CATransform3DTranslate(CATransform3DIdentity, CGFloat(transformFactor), 0.0, 0.0);
        } else {
            path.move(to: .init(x: 0, y: lineWidth/2))
            path.addLine(to: .init(x: self.bounds.maxX, y: lineWidth/2))
            count = Int(Double(self.bounds.height) / transformFactor) + 1
            transform = CATransform3DTranslate(CATransform3DIdentity, 0.0, CGFloat(transformFactor), 0.0);
            
        }
                
        line.path = path.cgPath

        (self.layer as? CAReplicatorLayer)?.instanceCount = count
        (self.layer as? CAReplicatorLayer)?.instanceTransform = transform
                
        self.layer.addSublayer(line)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        self._redraw()
    }
}
