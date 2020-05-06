//
//  ChecksView.swift
//  Test
//
//  Created by Vinay Jain on 05/05/20.
//  Copyright © 2020 Vinay Jain. All rights reserved.
//

import UIKit

class ChecksView: UIView {
    
    @IBInspectable var size: Double = 32 {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable var lineColor: UIColor! = .white {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable var lineWidth: CGFloat = 1 {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    private weak var horizontalLineView: LineView!
    private weak var verticalLineView: LineView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self._setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self._setup()
    }
    
    private func _setup() {
        let hLineView = LineView()
        hLineView.backgroundColor = .clear
        self.addSubview(hLineView)
        self.horizontalLineView = hLineView
        
        let vLineView = LineView()
        vLineView.backgroundColor = .clear
        vLineView.isVertical = true
        self.addSubview(vLineView)
        self.verticalLineView = vLineView
        
                        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.horizontalLineView.frame = self.bounds
        self.verticalLineView.frame = self.bounds
        
        self.horizontalLineView.lineColor = self.lineColor
        self.verticalLineView.lineColor = self.lineColor
        
        self.horizontalLineView.lineWidth = self.lineWidth
        self.verticalLineView.lineWidth = self.lineWidth
        
        self.horizontalLineView.spacing = self.size
        self.verticalLineView.spacing = self.size
    }
    
}
