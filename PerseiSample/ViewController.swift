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
  
  // Menuの中に表示する画像データ
  // 0 ~ 6までの数字をUIImageに変換している
  private let items = [Int](0..<7).map { MenuItem(image: UIImage(named: "menu_icon_\($0)")!) }
  
  // 本日のメイン
  // こいつをAddSubviewすることでオサレなメニューが表示される
  private weak var menu: MenuView!
  
  // メニューの下に表示する画像データのモデル
  // didSetを使ってmodelに値が代入されたときの動きを指定している
  private var model = ContentType.Films {
    didSet {
      title = model.description
      
      // Viewが全て読み込まれていればAnimationさせる
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
    
    // メインであるMenuViewの初期化
    loadMenu()
    
    title = model.description
    imageView.image = model.image
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: - menu view delegate
  // Menuの中の項目が選択されたときに呼ばれる
  func menu(menu: MenuView, didSelectItemAtIndex index: Int) {
    model = model.next()
  }
  
  // MARK: - button action
  @IBAction func switchMenu(sender: AnyObject) {
    menu.setRevealed(!menu.revealed, animated: true)
  }

  // MARK: - private method
  // MenuViewの初期化とtableViewへの追加
  private func loadMenu() {
    let menu = MenuView()
    menu.delegate = self
    menu.items = items
    
    tableView.addSubview(menu)
    
    self.menu = menu
  }
  
  // Animationの中心点を計算
  private func calcCenter() -> CGPoint {
    let itemFrame = menu.frameOfItemAtIndex(menu.selectedIndex!)
    let itemCenter = CGPoint(x: itemFrame.midX, y: itemFrame.midY)
    var convertedCenter = imageView.convertPoint(itemCenter, fromView: menu)
    
    convertedCenter.y = 0
    
    return convertedCenter
  }
}

