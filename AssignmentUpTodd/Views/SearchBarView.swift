//
//  SearchBarView.swift
//  AssignmentUpTodd
//
//  Created by Shivam Kumar on 26/02/25.
//

import SwiftUI
import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String

    var body: some View {
        HStack(alignment: .center) {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                
                TextField("Search Meals", text: $searchText)
                    .textFieldStyle(.plain)
                    .font(.system(size: 14))
                    .textInputAutocapitalization(.words)
                    
            }
            .padding(15)
            .background(Color.white)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.black) // Black border
            )
            
            Spacer()
            
            Image("filterImage")
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
        }
        
        
    }
}

#Preview {
    SearchBarView(searchText: .constant(""))
}
