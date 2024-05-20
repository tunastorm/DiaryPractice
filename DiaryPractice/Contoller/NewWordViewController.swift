//
//  NewWordViewController.swift
//  DiaryPractice
//
//  Created by 유철원 on 5/18/24.
//

import UIKit

class NewWordViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet
    var newWordSearchTextField: UITextField!
    
    @IBOutlet
    var newWordSearchButton: UIButton!
    
    @IBOutlet
    var newWordButtonCollections: [UIButton]!
    
    @IBOutlet
    var newWordDescLabel: UILabel!
    
    @IBOutlet
    var newWordDescImageView: UIImageView!
    
    let newWords: [String: String] = [
        "KIJUL" : "기절을 알파벳으로 표현한 것",
        "디토합니다" : "라틴어로 동의합니다",
        "가나디" : "강아지를 귀엽게 발음한 것",
        "잼얘" : "재밌는 얘기",
        "일며들다" : "삶에 일이 스며들었다",
        "추구미" : "내가 추구하는 이미지",
        "오우예씨몬" : "Oh Yeah C'mon을 씨몬으로 읽는 장난이 밈으로 굳은 것",
        "SBN" : "선배님",
        "내또출" : "내일 또 출근",
        "웅니" : "언니"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newWordSearchTextField.delegate = self
        
        setStaticContents()
        setDynamicContents()
        
    }
    
    func setStaticContents () {
        setViewsUI()
        setNewWordSearchTextFieldUI()
        setNewWordSearchButtonUI()
        setNewWordDescLabelUI()
        setNewWordDescImageViewUI()
    }
    
    func setDynamicContents () {
        setNewWordButtons()
        setTabGestureHideKeyboard()
    }
    
    func setViewsUI() {
        view.tintColor = .black
        view.viewWithTag(2)?.backgroundColor = .clear
    }
    
    func setNewWordSearchTextFieldUI() {
        newWordSearchTextField.borderStyle = .line
        newWordSearchTextField.layer.borderWidth = 2
        let padding = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 10.0, height: 0.0))
        newWordSearchTextField.leftView = padding
        newWordSearchTextField.rightView = padding
        newWordSearchTextField.leftViewMode = .always
        newWordSearchTextField.rightViewMode = .always
    }
    
    func setNewWordSearchButtonUI() {
        newWordSearchButton.configuration = .none
        newWordSearchTextField.frame.size = CGSize(width: newWordSearchTextField.frame.width,
                                                   height: newWordSearchButton.frame.height)
        newWordSearchButton.backgroundColor = .black
        newWordSearchButton.tintColor = .white
        
        if let image = UIImage(systemName: "magnifyingglass") {
            newWordSearchButton.setImage(image.resizableImage(withCapInsets: .init(), resizingMode: .tile), for: .normal)
            newWordSearchButton.imageView?.contentMode = .scaleAspectFit
        }
    }
    
    func setNewWordDescLabelUI() {
        newWordDescLabel.textAlignment = .center
        newWordDescLabel.numberOfLines = 0
        newWordDescLabel.text = ""
    }
    
    func setNewWordDescImageViewUI() {
        if let backgroundImage = UIImage(named: "background") {
            newWordDescImageView.contentMode = .scaleAspectFill
            newWordDescImageView.image = backgroundImage.withRenderingMode(.alwaysOriginal)
        }
    }
    
    func setNewWordButtons () {
        
        var randomWords: [String] = []
        
        // newWords가 정렬되지 않은 dictionary 타입 -> newWords.keys의 순서는 랜덤
        for newWord in newWords.keys {
            if randomWords.count < 4 {
                randomWords.append(newWord)
            } else { break }
        }
        
        for (idx, newWordButton) in newWordButtonCollections.enumerated() {
            let wordLength: Double = Double(randomWords[idx].count)
            
            newWordButton.configuration = .none
            newWordButton.layer.frame.size = CGSize(width: (wordLength * 10)+10,
                                                    height: newWordButton.frame.height)
            newWordButton.titleLabel?.textAlignment = .center
            newWordButton.titleLabel?.font = .systemFont(ofSize: 12)
            newWordButton.setTitle(randomWords[idx], for: .normal)
            
            newWordButton.layer.cornerRadius = newWordButton.frame.height * 0.1
            newWordButton.layer.borderWidth = 1
            newWordButton.layer.borderColor = UIColor.black.cgColor
        }
        
    }
    
    func setTabGestureHideKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboard))
        tapGesture.cancelsTouchesInView = true
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func hideKeyboard() {
        if self.isEditing {
            view.endEditing(true)
        }
    }
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        hideKeyboard()
//    }
    
    func textFieldShouldReturn(_ sender: UITextField) -> Bool {
        if sender == newWordSearchTextField {
            newWordSearchButtonPushUp(newWordSearchButton)
            newWordSearchTextField.resignFirstResponder()
        }
        return true
    }
    
    func setSearchDescLabelText (searchWord: String) {
        newWordDescLabel.text = newWords.keys.contains(searchWord) ? 
                                newWords[searchWord] : "검색결과가 없습니다."
    }
    
    @IBAction
    func newWordSearchButtonPushUp(_ sender: UIButton) {
        if let searchWord = newWordSearchTextField.text {
           setSearchDescLabelText(searchWord: searchWord)
        }
        if newWordSearchTextField.isFirstResponder {
            self.isEditing = true
            hideKeyboard()
        }
    }
    
    @IBAction
    func newWordButtonsPushUp(_ sender: UIButton) {
        if newWordSearchTextField.isFirstResponder {
            self.isEditing = true
            hideKeyboard()
        }
        
        if let searchWord = sender.title(for: .normal) {
            setSearchDescLabelText(searchWord: searchWord)
            newWordSearchTextField.text = searchWord
        }
       
    }
    
}
