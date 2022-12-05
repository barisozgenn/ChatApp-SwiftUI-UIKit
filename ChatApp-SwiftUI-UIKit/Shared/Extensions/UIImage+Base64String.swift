//
//  UIImage+Base64String.swift
//  ChatApp-SwiftUI-UIKit
//
//  Created by Baris OZGEN on 5.12.2022.
//

import SwiftUI

extension UIImage {
    func convertToBase64String () -> String {
        return self.jpegData(compressionQuality: 1)?.base64EncodedString() ?? ""
    }
}
extension String {
    func convertBase64ToUIImage () -> UIImage {
        let imageData = Data(base64Encoded: self)
        let image = UIImage(data: imageData!)
        return image!
    }
}
