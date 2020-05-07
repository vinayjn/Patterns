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
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable public var spacing: Double = 32 {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable public var lineWidth: CGFloat = 1 {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable public var isVertical: Bool = false {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    private weak var pattern: CAShapeLayer!
    private weak var replicator: CAReplicatorLayer!
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self._setup()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        self._setup()
    }
    
    private func _setup() {
        let pattern = CAShapeLayer()
        
        let replicator = CAReplicatorLayer()
        replicator.addSublayer(pattern)
        self.pattern = pattern        
        self.layer.insertSublayer(replicator, at: 0)
        self.replicator = replicator
    }
    
    private func _redraw() {

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
        pattern.strokeColor = self.lineColor.cgColor
        pattern.lineWidth = self.lineWidth
        pattern.path = path.cgPath
        replicator.instanceCount = count
        replicator.instanceTransform = transform
    }
    
    public override func layoutSubviews() {
        self.replicator.frame = self.bounds
        self._redraw()
        super.layoutSubviews()
    }
}
