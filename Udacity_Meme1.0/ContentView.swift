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
        editImageView
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
    
    private var editImageView: some View {
        VStack {
            centerView
                .background(Color.green)
                .frame(maxHeight: .infinity)
                .overlay {
                    VStack {
                        MemeTextField(text: $topText, placeHolder: "Top", fontName: selectedFontName)
                        Spacer()
                        MemeTextField(text: $bottomText, placeHolder: "Bottom", fontName: selectedFontName)
                    }
                }
            bottomView
                .frame(maxWidth: .infinity, maxHeight: 60)
                .background {
                    Rectangle()
                        .fill(Color.gray)
                }
        }
        .background(Color.black)
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
            if let selectedImage = selectedImage {
                let editImageView = editImageView.snapshot()
                ShareLink(
                    item: selectedImage,
                    preview: SharePreview("Beautiful Image", image: selectedImage)) {
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

extension View {
    func snapshot() -> UIImage {
        let controller = UIHostingController(rootView: self)
        let view = controller.view
 
        let targetSize = controller.view.intrinsicContentSize
        view?.bounds = CGRect(origin: .zero, size: targetSize)
        view?.backgroundColor = .clear
 
        let renderer = UIGraphicsImageRenderer(size: targetSize)
 
        return renderer.image { _ in
            view?.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
        }
    }
}
