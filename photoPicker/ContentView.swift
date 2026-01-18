//
//  ContentView.swift
//  photoPicker
//
//  Created by Mohsin khan on 23/10/2025.
//

import PhotosUI
import SwiftUI

struct ContentView: View {
    @State private var pickerItems = [PhotosPickerItem]()
    @State private var selectedImages = [Image]()

    var body: some View {
        VStack{
            PhotosPicker(selection: $pickerItems ,maxSelectionCount: 5 , matching: .images){
                Label("select images" , systemImage: "photo")
            }

            ScrollView{
                ForEach(0..<selectedImages.count , id: \.self){i in
                    selectedImages[i]
                        .resizable()
                        .scaledToFit()
                }
            }
        }
        .onChange(of: pickerItems){
            Task{
                selectedImages.removeAll()

                for item in pickerItems{

                    if let loadedImage = try await item.loadTransferable(type: Image.self){
                        selectedImages.append(loadedImage)
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}


//import SwiftUI
//import PhotosUI
//import AVKit
//
//struct ContentView: View {
//    @State private var pickerItems = [PhotosPickerItem]()
//    @State private var selectedVideoURLs = [URL]()
//    
//    var body: some View {
//        VStack {
//            PhotosPicker(selection: $pickerItems, maxSelectionCount: 3, matching: .videos) {
//                Label("Select videos", systemImage: "video")
//            }
//            
//            ScrollView {
//                ForEach(selectedVideoURLs, id: \.self) { url in
//                    VideoPlayer(player: AVPlayer(url: url))
//                        .frame(height: 300)
//                        .cornerRadius(12)
//                        .padding()
//                }
//            }
//        }
//        .onChange(of: pickerItems) {
//            Task {
//                selectedVideoURLs.removeAll()
//                
//                for item in pickerItems {
//                    // 1️⃣ Load the video file data
//                    if let data = try? await item.loadTransferable(type: Data.self) {
//                        // 2️⃣ Create a new file URL in the app’s Documents folder
//                        let tempURL = FileManager.default.temporaryDirectory.appendingPathComponent("\(UUID().uuidString).mov")
//                        
//                        // 3️⃣ Write the data to the file
//                        try? data.write(to: tempURL)
//                        
//                        // 4️⃣ Add the URL to our array
//                        selectedVideoURLs.append(tempURL)
//                    }
//                }
//            }
//        }
//    }
//}
//
//#Preview {
//    ContentView()
//}
