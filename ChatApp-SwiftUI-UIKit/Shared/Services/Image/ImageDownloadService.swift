//
//  ImageDownloadService.swift
//  ChatApp-SwiftUI-UIKit
//
//  Created by Baris OZGEN on 26.11.2022.
//

import UIKit
struct ImageDownloadService {
    static func downloadImage(imageUrl: String, folderType: FirebaseFileType, completion: @escaping(_ image: UIImage) -> ()) {
        let ref = "\(folderType.folderName)\(imageUrl)"
        
        
    }
}
