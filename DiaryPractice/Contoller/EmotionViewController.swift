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
        setViewContainerUI()
        setButtonsUI()
    }
    
    func setDynamicContents() {
        var buttonContents: [String:String] = setButtonContents()
        setButtonsEmotion(contents: buttonContents)
    }
    
    func setViewContainerUI() {
        self.navigationItem.title = "감정 다이어리"
        
        view.tintColor = .black
        if let backgroundImage = UIImage(named: "scratched paper") {
            view.backgroundColor = UIColor(patternImage: backgroundImage)
        }
    }
    
    func setButtonsUI() {
        // change buttons view background color
        view.viewWithTag(1)?.backgroundColor = UIColor.clear
        view.viewWithTag(2)?.backgroundColor = UIColor.clear
        view.viewWithTag(3)?.backgroundColor = UIColor.clear
        view.viewWithTag(4)?.backgroundColor = UIColor.clear
    }
    
    
    func setButtonsEmotion(contents: [String:String]) {
        var emotions: [String] = []
        
        for key in contents.keys {
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
                    
            if let emotionImage = contents[emotion] {
                emotionImageButton.setBackgroundImage(UIImage(named:emotionImage)?
                                                      .withRenderingMode(.alwaysOriginal), for: .normal)
            }
            
        }
        
    }
    
    func setButtonContents() -> [String:String] {
        // asset 폴더 내의 asset들 중 이름에 slime이 들어간 이미지셋의 이름만을 추출
        let assetDirPath = "/Users/ucheol/dev/SeSAC/assignment/DiaryPractice/DiaryPractice/Assets.xcassets"
        var assetLoader: AssetLoader = AssetLoader(directoryPath: assetDirPath)
        var neededAssets: [String] = assetLoader.getAssetNames(contains: "slime")
        
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
        
        for asset in neededAssets {
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
    func emotionButtonsPushUp(_ sender: UIButton) {
        // push up 이벤트 발생한 버튼의 title 문자열 추출
        var senderTitle: String = sender.title(for: .normal) ?? "nil"
        
        let oldTitle = senderTitle.split(separator: " ")
        let emotion = String(oldTitle.first ?? "nil")
        var newTitle: String = "nil"
        var oldCount: Int = 0
        
        // sender의 title 값이 없을 경우 예외처리
        if senderTitle == "nil" || emotion == "nil" {
            return
        }
        
        // 기존에 카운트된 경우와 아닌 경우로 분기해 NewTitle 지정
        if oldTitle.count == 2 { // 기존 카운트 + 1
            oldCount = Int(String(oldTitle.last ?? "-1")) ?? -1
            let newCount = oldCount + 1
            newTitle = "\(emotion) \(newCount)"
            
        } else if oldTitle.count == 1 { // 최초 카운트
            newTitle = "\(emotion) 1"
        }
        
        // newTitle 설정 실패시 예외처리
        if newTitle == "nil" || oldCount < 0 {
            return
        }
        
        // emotionCountButton 순회하여 title이 일치하는 것에 newTitle 적용
        for countButton in emotionCountButtonCollection {
            if countButton.title(for: .normal) == senderTitle {
                countButton.setTitle(newTitle, for: .normal)
                break
            }
        }
        
        // emotionImageButton 순회하여 title이 일치하는 것에 newTitle 적용
        for emotionImageButton in emotionImageButtonCollection {
            if emotionImageButton.title(for: .normal) == senderTitle {
                emotionImageButton.setTitle(newTitle, for: .normal)
                break
            }
        }
        
    }
}
