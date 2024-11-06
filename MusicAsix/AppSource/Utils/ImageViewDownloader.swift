//
//  ImageViewDownloader.swift
//  MusicAsix
//
//  Created by Bijantyum on 05/11/24.
//

import UIKit


extension UIImageView{
    
    
    /// <#Description#>
    /// - Parameter url: to be loaded
    func load(url: URL){
        DispatchQueue.global().async{
            if let data = try? Data(contentsOf:url){
                if let image = UIImage(data: data){
                    DispatchQueue.main.async{
                        self.image = image
                    }
                }
            }
        }
    }
}
