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
                if let slicedName = asset.split(separator: ".").first {
                    if slicedName.contains(contains){
                        allAssetNames.append(String(slicedName))
                    }
                }
            }
//            let deeperContents = try fileManager.subpathsOfDirectory(atPath: directoryPath)
           
        } catch let error as NSError {
            print("Error access directory: \(error)")
        }
        
        return allAssetNames
    }

}
