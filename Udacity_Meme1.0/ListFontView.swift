//
//  ListFontView.swift
//  Udacity_Meme1.0
//
//  Created by Work on 01/03/2024.
//

import SwiftUI

struct ListFontView: View {
    
    let fontsAvailable = UIFont.familyNames
    @Binding var selectedFontName: String?
    
    var body: some View {
        List(fontsAvailable, id: \.self, selection: $selectedFontName) { item in
            Text(item)
                .font(.custom(item, size: 20))
        }
    }
}

#Preview {
    ListFontView(selectedFontName: .constant(""))
}
