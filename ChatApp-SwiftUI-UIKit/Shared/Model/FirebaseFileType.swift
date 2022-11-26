//
//  FirebaseFileType.swift
//  ChatApp-SwiftUI-UIKit
//
//  Created by Baris OZGEN on 26.11.2022.
//

import Foundation

enum FirebaseFileType: String, CaseIterable, Identifiable {
    case profile
    case messageImage
    case messageAudio
    case messageVideo
    
    var id : String { return rawValue}
    
    var compressValue: Double {
        switch self {
        case .profile: return 0.7
        case .messageImage, .messageAudio, .messageVideo: return 0.14
        }
    }
    
    var folderName: String
    {
        switch self {
        case .profile: return "/user/profile_images/"
        case .messageImage: return "/message/images/"
        case .messageAudio: return "/message/audio/"
        case .messageVideo: return "/message/video/"
        }
    }
    
    private var filePreName: String
    {
        switch self {
        case .profile: return "pi_"
        case .messageImage: return "mi_"
        case .messageAudio: return "ma_"
        case .messageVideo: return "mv_"
        }
    }
    
    func createFileName() -> String {
        return "\(filePreName)\(NSUUID().uuidString)"
    }
    
    func getFolderPath(fileName: String) -> String {
        return "\(folderName)\(fileName)"
    }
}
