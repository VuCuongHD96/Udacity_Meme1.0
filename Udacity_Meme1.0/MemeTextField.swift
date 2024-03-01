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
    
    var body: some View {
        TextField(text: $text) {
            Text(placeHolder)
                .font(.title)
                .foregroundColor(.white)
        }
        .multilineTextAlignment(.center)
        .padding(5)
        .background(Color.yellow)
        .cornerRadius(8)
        .padding(30)
    }
}

#Preview {
    VStack {
        MemeTextField(text: .constant("This is top"), placeHolder: "Top")
        MemeTextField(text: .constant("This is bottom"), placeHolder: "Bottom")
    }
}
