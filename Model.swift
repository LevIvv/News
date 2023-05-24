//
//  Model.swift
//  News
//
//  Created by Лев Ивлев on 25.04.2023.
//

import Foundation

var articles: [Article] {
    let path = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)[0]+"/data.json"
    let urlPath = URL(fileURLWithPath: path)
    let data = try? Data(contentsOf: urlPath)
    if data==nil {
        return []
    }
    
    let rootDict = try? JSONSerialization.jsonObject(with: data!, options: .fragmentsAllowed)
    if rootDict == nil{
        return []
    }
    let rootDictionary = rootDict as? Dictionary<String, Any>
    if rootDictionary == nil {
        return []
    }
    
    if let array = rootDictionary!["articles"] as? [Dictionary<String, Any>]{
        var returnedArray: [Article] = []
        for dict in array{
            let newArticle = Article(dictionary: dict)
            returnedArray.append(newArticle)
            
        }
        return returnedArray
    }
    return []
    
}

func getNews(compliteonHandler: (()->Void)?) {
    let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=146fdebd5e40461eb77f21ab47546fb1")
    URLSession.shared.downloadTask(with: url!) { urlFile, responce, error in
        if urlFile != nil {
            let path = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)[0]+"/data.json"
            let urlPath = URL(fileURLWithPath: path)
            
            if FileManager.default.fileExists(atPath: path){
                do{
                    try FileManager.default.removeItem(atPath: path)
                }catch let error {
                    print("error occurred, here are the details:\n \(error)")
                }
            }
            
            try? FileManager.default.copyItem(at: urlFile!, to: urlPath)
            compliteonHandler?()
        }
    }.resume()
   
}
