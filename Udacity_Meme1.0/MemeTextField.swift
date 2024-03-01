//
//  MemeTextField.swift
//  Udacity_Meme1.0
//
//  Created by Work on 01/03/2024.
//

import SwiftUI

struct MemeTextField: View {
    
    @Binding var text: String
    var placeHolder: String
    var fontName: String?
    
    var body: some View {
        TextField(text: $text) {
            Text(placeHolder)
                .foregroundColor(.white)
        }
        .font(.custom(fontName ?? "Arial", size: 20))
        .multilineTextAlignment(.center)
        .padding(5)
        .cornerRadius(8)
        .background(Color.gray.opacity(0.2))
        .padding(20)
        .foregroundColor(.white)
    }
}

#Preview {
    VStack {
        MemeTextField(text: .constant("This is top"), placeHolder: "Top", fontName: "Bodoni 72 Oldstyle")
        MemeTextField(text: .constant("This is bottom"), placeHolder: "Bottom", fontName: "Arial Rounded MT Bold")
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color.black)
}
