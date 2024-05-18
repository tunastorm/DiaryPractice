//
//  AssetLoader.swift
//  DiaryPractice
//
//  Created by 유철원 on 5/18/24.
//

import Foundation

class AssetLoader {
    let fileManager: FileManager
    let directoryPath: String
    
    convenience init(directoryPath: String) {
        let fileManager = FileManager()
        self.init(fileManager: fileManager, directoryPath: directoryPath)
    }
    
    private init(fileManager: FileManager, directoryPath: String) {
        self.fileManager = fileManager
        self.directoryPath = directoryPath
    }
    
    func getAssetNames(contains: String) -> [String] {
        var allAssetNames: [String] = []
        
        do {
            let contents = try fileManager.contentsOfDirectory(atPath: directoryPath)
            
            for asset in contents {
                // Asset의 확장자 제거하고 이름만 추출
                if let slicedName = asset.split(separator: ".").first {
                    // 호출시 입력한 문자열과 일치하는 것만 반환
                    if slicedName.contains(contains){
                        allAssetNames.append(String(slicedName))
                    }
                }
            }
    
        } catch let error as NSError {
            print("Error access directory: \(error)")
        }
        
        return allAssetNames
    }

}
