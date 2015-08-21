//
//  CircularRevealTransition.swift
//  PerseiSample
//
//  Created by yuichiro_t on 2015/08/22.
//  Copyright (c) 2015年 yuichiro_t. All rights reserved.
//

import UIKit

class CircularRevealTransition {
  
  var completion: () -> Void = {}
  
  private let layer: CALayer
  private let snapshotLayer = CALayer()
  private let mask = CAShapeLayer()
  private let animation = CABasicAnimation(keyPath: "path")
  
  // MARK: - initializer
  init(layer: CALayer, center: CGPoint, startRadius: CGFloat, endRadius: CGFloat) {
    let startPath = CGPathCreateWithEllipseInRect(CGRect(boundingCenter: center, radius: startRadius), nil)
    let endPath = CGPathCreateWithEllipseInRect(CGRect(boundingCenter: center, radius: endRadius), nil)
    
    self.layer = layer
    snapshotLayer.contents = layer.contents
    
    mask.path = endPath
    
    animation.duration = 0.6
    animation.fromValue = startPath
    animation.toValue = endPath
    animation.delegate = self
  }
  
  convenience init(layer: CALayer, center: CGPoint) {
    let frame = layer.frame
    
    let radius: CGFloat = {
      let x = max(center.x, frame.width - center.x)
      let y = max(center.y, frame.height - center.y)
      
      return sqrt(x * x + y * y)
    }()
    
    self.init(layer: layer, center: center, startRadius: 0, endRadius: radius)
  }
  
  // MARK: - public method
  func start() {
    layer.superlayer.insertSublayer(snapshotLayer, below: layer)
    snapshotLayer.frame = layer.frame
    
    layer.mask = mask
    mask.frame = layer.bounds
    
    mask.addAnimation(animation, forKey: "reveal")
  }
  
  
  // MARK: CAAnimation delegate
  @objc
  private func animationDidStop(_: CAAnimation, finished: Bool) {
    layer.mask = nil
    snapshotLayer.removeFromSuperlayer()
    
    completion()
  }
}
