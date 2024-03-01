//
//  ContentView.swift
//  Udacity_Meme1.0
//
//  Created by Work on 01/03/2024.
//

import SwiftUI
import PhotosUI

struct ContentView: View {
    
    @State private var pickerItem: PhotosPickerItem?
    @State private var selectedImage: Image?
    @State private var topText = ""
    @State private var bottomText = ""
    
    var body: some View {
        VStack {
            MemeTextField(text: $topText, placeHolder: "Top")
            centerView
                .frame(maxHeight: .infinity)
            MemeTextField(text: $bottomText, placeHolder: "Bottom")
            bottomView
                .frame(maxWidth: .infinity, maxHeight: 60)
                .background {
                    Rectangle()
                        .fill(Color.gray)
                }
        }
        .ignoresSafeArea(edges: .bottom)
        .background(Color.green)
        .onChange(of: pickerItem) {
            Task {
                if let data = try? await pickerItem?.loadTransferable(type: Data.self) {
                    if let image = UIImage(data: data) {
                        selectedImage = Image(uiImage: image)
                    }
                }
            }
        }
    }
    
    private var centerView: some View {
        if let image = selectedImage {
            return AnyView(
                image
                    .resizable()
                    .scaledToFit()
            )
        } else {
            return AnyView(
                Image("no_image")
                    .resizable()
                    .scaledToFit()
            )
        }
    }
    
    private var bottomView: some View {
        HStack {
            Spacer()
            PhotosPicker(selection: $pickerItem, matching: .images) {
                Image("album")
            }
            Spacer()
            Image("edit")
            Spacer()
        }
    }
}

#Preview {
    ContentView()
}
