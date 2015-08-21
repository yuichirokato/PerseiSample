//
//  CGRectExtension.swift
//  PerseiSample
//
//  Created by yuichiro_t on 2015/08/22.
//  Copyright (c) 2015年 yuichiro_t. All rights reserved.
//

import UIKit

extension CGRect {
  init(boundingCenter center: CGPoint, radius: CGFloat) {
    assert(0 <= radius, "radius must be a positive value")
    
    self = CGRectInset(CGRect(origin: center, size: CGSizeZero), -radius, -radius)
  }
}
