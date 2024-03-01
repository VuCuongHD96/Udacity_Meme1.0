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
    
    var body: some View {
        VStack {
            MemeTextField(text: $topText, placeHolder: "Top", fontName: selectedFontName)
            centerView
                .frame(maxHeight: .infinity)
                .background(Color.green)
            MemeTextField(text: $bottomText, placeHolder: "Bottom", fontName: selectedFontName)
            bottomView
                .frame(maxWidth: .infinity, maxHeight: 60)
                .background {
                    Rectangle()
                        .fill(Color.gray)
                }
        }
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
        .sheet(isPresented: $isOpenAlbum) {
            ListFontView(selectedFontName: $selectedFontName)
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
                .onTapGesture {
                    isOpenAlbum.toggle()
                }
            Spacer()
        }
    }
}

#Preview {
    ContentView()
}
