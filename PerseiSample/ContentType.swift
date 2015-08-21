//
//  ContentType.swift
//  PerseiSample
//
//  Created by yuichiro_t on 2015/08/22.
//  Copyright (c) 2015年 yuichiro_t. All rights reserved.
//

import UIKit

enum ContentType: String, Printable {
  case Music = "content_music.png"
  case Films = "content_films.png"
  
  var image: UIImage {
    let image = UIImage(named: rawValue)!
    return image
  }
  
  var description: String {
    switch self {
    case .Music: return "Music"
    case .Films: return "Films"
    }
  }
  
  func next() -> ContentType {
    switch self {
    case .Music: return .Films
    case .Films: return .Music
    }
  }
  
}
