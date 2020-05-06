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
        
        
        path.move(to: .zero)
        
        let count: Int
        let transform: CATransform3D
        if isVertical {
            path.addLine(to: .init(x: 0, y: self.bounds.maxY))
            count = Int(Double(self.bounds.width) / spacing) + 1
            transform = CATransform3DTranslate(CATransform3DIdentity, CGFloat(spacing), 0.0, 1.0);
        } else {
            path.addLine(to: .init(x: self.bounds.maxX, y: 0))
            count = Int(Double(self.bounds.height) / spacing) + 1
            transform = CATransform3DTranslate(CATransform3DIdentity, 0.0, CGFloat(spacing), 1.0);
            
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
