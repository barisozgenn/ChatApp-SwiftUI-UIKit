//
//  ImageUploadService.swift
//  ChatApp-SwiftUI-UIKit
//
//  Created by Baris OZGEN on 26.11.2022.
//

import UIKit
struct ImageUploadService {

    static func uploadImage(image: UIImage, folderType: FirebaseFileType, completion: @escaping(String, String) -> Void){
        guard let imageData = image.jpegData(compressionQuality: folderType.compressValue) else {return}
        
        let fileName = folderType.createFileName()
        
        let ref = folderType.getFolderPath(fileName: fileName)
        
    }
}

