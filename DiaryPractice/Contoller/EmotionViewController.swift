//
//  EmotionViewController.swift
//  DiaryPractice
//
//  Created by 유철원 on 5/18/24.
//

import UIKit

class EmotionViewController: UIViewController {

    @IBOutlet
    var emotionImageButtonCollection: [UIButton]!
    
    @IBOutlet
    var emotionCountButtonCollection: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setStaticContents()
        setDynamicContents()
       
    }
    
    func setStaticContents() {
        self.navigationItem.title = "감정 다이어리"
        
        view.tintColor = .black
        
        if let backgroundImage = UIImage(named: "scratched paper"){
            view.backgroundColor = UIColor(patternImage: backgroundImage)
        }
        
        // change buttons view background color
        view.viewWithTag(1)?.backgroundColor = UIColor.clear
        view.viewWithTag(2)?.backgroundColor = UIColor.clear
        view.viewWithTag(3)?.backgroundColor = UIColor.clear
        view.viewWithTag(4)?.backgroundColor = UIColor.clear
        
    }
    
    func setDynamicContents() {
        
        setEmotionBuuttons()
        
    }
    
    func setEmotionBuuttons() {
        let buttonContents = setButtonContents()
        var emotions: [String] = []
        
        for key in buttonContents.keys {
            emotions.append(String(key))
        }
        
        for (idx, emotionCountButton) in emotionCountButtonCollection.enumerated() {
            
            let emotion: String = emotions[idx]
            
            emotionCountButton.configuration = .none
            emotionCountButton.titleLabel?.font = .systemFont(ofSize: 12)
            emotionCountButton.setTitle("\(emotion)", for: .normal)
        }
        
        for (idx, emotionImageButton) in emotionImageButtonCollection.enumerated() {
            
            let emotion: String = emotions[idx]
            
            emotionImageButton.configuration = .none
            emotionImageButton.setTitle(emotion, for: .normal)
            emotionImageButton.setTitleColor(.clear, for: .normal)
                    
            if let emotionImage = buttonContents[emotion] {
                emotionImageButton.setBackgroundImage(UIImage(named:emotionImage)?.withRenderingMode(.alwaysOriginal), for: .normal)
    
            }
            
        }
        
    }
    
    func setButtonContents() -> [String:String] {
        var buttonContents: [String : String] = [
            // emotion : image file
            "행복해":"",
            "사랑해":"",
            "좋아해":"",
            "당황해":"",
            "속상해":"",
            "우울해":"",
            "심심해":"",
            "따분해":"",
            "울적해":""
        ]
        
        let assetDirPath = "/Users/ucheol/dev/SeSAC/assignment/DiaryPractice/DiaryPractice/Assets.xcassets"
        
        var assetLoader: AssetLoader = AssetLoader(directoryPath: assetDirPath)
        var allAssets: [String] = assetLoader.getAssetNames(contains: "slime")
        // var buttonKeys: [String] = buttonContents.keys.sorted()
        
        for asset in allAssets {
            switch asset {
                case "slime1": buttonContents["행복해"] = asset
                case "slime2": buttonContents["사랑해"] = asset
                case "slime3": buttonContents["좋아해"] = asset
                case "slime4": buttonContents["당황해"] = asset
                case "slime5": buttonContents["속상해"] = asset
                case "slime6": buttonContents["우울해"] = asset
                case "slime7": buttonContents["심심해"] = asset
                case "slime8": buttonContents["따분해"] = asset
                case "slime9": buttonContents["울적해"] = asset
            default: break
            }
        }
    
        return buttonContents
    }
    
    @IBAction
    func emotionButtonPushUp(_ sender: UIButton) {
        // push up 이벤트 발생한 버튼의 title을 가져옴
        var senderTitle: String = sender.title(for: .normal) ?? "none"
        
        let oldTitle = senderTitle.split(separator: " ")
        let emotion = String(oldTitle.first ?? "none")
        var newTitle: String = "none"
        var oldCount: Int = 0
        
        if senderTitle == "none" || emotion == "none"{
            return
        }
        
        // 기존에 카운트된 경우와 아닌 경우로 분기해 NewTitle 지정
        if oldTitle.count == 1{
            newTitle = "\(emotion) 1"
        } else if oldTitle.count == 2 {
            oldCount = Int(String(oldTitle.last ?? "-1")) ?? -1
            let newCount = oldCount + 1
            newTitle = "\(emotion) \(newCount)"
        }
        
        if newTitle == "none" || oldCount < 0{
            return
        }
        
        // emotionCountButton 순회하여 title이 일치하는 것에 newTitle 적용
        for countButton in emotionCountButtonCollection {
            if countButton.title(for: .normal) == senderTitle {
                countButton.setTitle(newTitle, for: .normal)
            }
        }
        
        // emotionImageButton 순회하여 title이 일치하는 것에 newTitle 적용
        for emotionImageButton in emotionImageButtonCollection {
            if emotionImageButton.title(for: .normal) == senderTitle {
                emotionImageButton.setTitle(newTitle, for: .normal)
            }
        }
        
    }
}
