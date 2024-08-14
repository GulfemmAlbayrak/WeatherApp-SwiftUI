//
//  URLImage.swift
//  WeatherApp-SwiftUI
//
//  Created by Gulfem ALBAYRAK on 13.08.2024.
//

import SwiftUI

struct URLImage: View {
    let url: String
    let placeholder: String
    
    @ObservedObject var imageLoader = ImageLoader()
    
    init(url: String, placeholder: String = "ğlaceholder") {
        self.url = url
        self.placeholder = placeholder
        self.imageLoader.downloadedImage(url: self.url)
    }
    
    var body: some View {
        if let data = self.imageLoader.downloadedData {
            return Image(uiImage: UIImage(data: data)!).resizable()
        } else {
            return Image("placeholder").resizable()
        }
    }
}

#Preview {
    URLImage(url: "https://fyrafix.files.wordpress.com/2011/08/url-8.jpg")
}
