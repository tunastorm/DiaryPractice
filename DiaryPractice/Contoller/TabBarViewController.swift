//
//  TabBarViewController.swift
//  DiaryPractice
//
//  Created by 유철원 on 5/19/24.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.tintColor = UIColor.black
        tabBar.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        tabBar.layer.borderWidth = 1
        tabBar.layer.borderColor = UIColor.black.cgColor
        
        let itemNames: [String:String] = [
            "감정 다이어리": "heart.text.square",
            "신조어 찾기": "magnifyingglass"
        ]
        
        var nameList: [String] = []
        
        for name in itemNames.keys.sorted() {
            nameList.append(name)
        }
        
        if let itemList = tabBar.items?.enumerated() {
            for (idx, item) in itemList {
                let name =  nameList[idx]
                item.title = name
                item.image = UIImage(systemName: itemNames[name]!)?.withRenderingMode(.alwaysOriginal)
                
            }
        }
    }
    
}
