//
//  ViewController.swift
//  PerseiSample
//
//  Created by yuichiro_t on 2015/08/17.
//  Copyright (c) 2015年 yuichiro_t. All rights reserved.
//

import UIKit
import Persei

class ViewController: UITableViewController, MenuViewDelegate {

  @IBOutlet weak var imageView: UIImageView!
  
  private let items = [Int](0..<7).map { MenuItem(image: UIImage(named: "menu_icon_\($0)")!) }
  
  private weak var menu: MenuView!
  
  private var model = ContentType.Films {
    didSet {
      title = model.description
      
      if isViewLoaded() {
        let transition = CircularRevealTransition(layer: imageView.layer, center: calcCenter())
        transition.start()
        
        imageView.image = model.image
      }
    }
  }
  
  // MARK: - life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    loadMenu()
    
    title = model.description
    imageView.image = model.image
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: - menu view delegate
  func menu(menu: MenuView, didSelectItemAtIndex index: Int) {
    model = model.next()
  }
  
  // MARK: - button action
  @IBAction func switchMenu(sender: AnyObject) {
    menu.setRevealed(!menu.revealed, animated: true)
  }

  // MARK: - private method
  private func loadMenu() {
    let menu = MenuView()
    menu.delegate = self
    menu.items = items
    
    tableView.addSubview(menu)
    
    self.menu = menu
  }
  
  private func calcCenter() -> CGPoint {
    let itemFrame = menu.frameOfItemAtIndex(menu.selectedIndex!)
    let itemCenter = CGPoint(x: itemFrame.midX, y: itemFrame.midY)
    var convertedCenter = imageView.convertPoint(itemCenter, fromView: menu)
    
    convertedCenter.y = 0
    
    return convertedCenter
  }
}

