//
//  LazyNavigationView.swift
//  ChatAppSwiftUI
//
//  Created by Baris OZGEN on 1.12.2022.
//

import SwiftUI

struct LazyNavigationView<Content : View> : View {
    let build: () -> Content
    
    init(build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    
    var body: Content{
        build()
    }
}
