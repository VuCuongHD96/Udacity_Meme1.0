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
    @State private var selectedFontName: String?
    @State private var isOpenAlbum = false
    @State private var renderImage: Image?

    var body: some View {
        VStack {
            centerView
            bottomView
                .frame(maxWidth: .infinity, maxHeight: 60)
                .background {
                    Rectangle()
                        .fill(Color.gray)
                }
        }
        .background(Color.black)
        .ignoresSafeArea(edges: .bottom)
        .onChange(of: pickerItem) {
            Task {
                if let data = try? await pickerItem?.loadTransferable(type: Data.self) {
                    if let image = UIImage(data: data) {
                        selectedImage = Image(uiImage: image)
                    }
                }
            }
        }
        .onChange(of: selectedFontName) {
            isOpenAlbum.toggle()
        }
        .onChange(of: selectedImage) {
            let renderer = ImageRenderer(content: centerView)
            if let image = renderer.cgImage {
                renderImage = Image(decorative: image, scale: 1.0)
            }
        }
        .sheet(isPresented: $isOpenAlbum) {
            ListFontView(selectedFontName: $selectedFontName)
        }
    }
    
    private var selectImage: Image {
        if let image = selectedImage {
            image
        } else {
            Image("no_image")
        }
    }
    
    private var centerView: some View {
        selectImage
            .resizable()
            .scaledToFit()
            .background(Color.green)
            .frame(maxHeight: .infinity)
            .overlay {
                VStack {
                    MemeTextField(text: $topText, placeHolder: "Top", fontName: selectedFontName)
                    Spacer()
                    MemeTextField(text: $bottomText, placeHolder: "Bottom", fontName: selectedFontName)
                }
            }
    }
    
    private var bottomView: some View {
        HStack {
            if let renderImage = renderImage {
                ShareLink(
                    item: renderImage,
                    preview: SharePreview("Beautiful Image", image: renderImage)) {
                        Image("share")
                    }
                    .frame(maxWidth: .infinity)
            }
            PhotosPicker(selection: $pickerItem, matching: .images) {
                Image("album")
            }
            .frame(maxWidth: .infinity)
            Image("edit")
                .onTapGesture {
                    isOpenAlbum.toggle()
                }
                .frame(maxWidth: .infinity)
        }
        .animation(.default, value: selectedImage)
    }
}

#Preview {
    ContentView()
}
