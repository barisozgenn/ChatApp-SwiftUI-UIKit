//
//  ImageDownloadService.swift
//  ChatApp-SwiftUI-UIKit
//
//  Created by Baris OZGEN on 26.11.2022.
//

import UIKit
import Firebase
import FirebaseStorage

struct ImageDownloadService {
    static func downloadImage(imageUrl: String, folderType: FirebaseFileType, completion: @escaping(_ image: UIImage) -> ()) {
        let ref = Storage.storage().reference(withPath: "\(folderType.folderName)\(imageUrl)")
        
        ref.getData(maxSize: 1 * 1024 * 1024) { data, _ in
            
            guard let data = data,
                  let uiImage = UIImage(data: data) else {return}
            
             completion(uiImage)
        }
    }
}
