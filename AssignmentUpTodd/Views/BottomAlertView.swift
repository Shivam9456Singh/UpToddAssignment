//
//  BottomAlertView.swift
//  AssignmentUpTodd
//
//  Created by Shivam Kumar on 27/02/25.
//

import SwiftUI
struct BottomAlertView: View {
    @Binding var isPresented: Bool
    var onFeedTapped: () -> Void
    
    var body: some View {
        VStack {
            VStack(alignment: .center) {
                HStack {
                    Button(action: {
                        onFeedTapped()
                        isPresented = false
                    }) {
                        Text("Fed?")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(red : 76/255 , green : 88/255 , blue : 217/255))
                            .cornerRadius(50)
                    }
                    Button(action: {
                        isPresented = false
                    }) {
                        Text("Cancel")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(50)
                            
                    }
                    
                }
                .padding(.horizontal)
            }
            .frame(width: 310, height: 130, alignment: .center)
            .cornerRadius(10)
            .shadow(radius: 10)
            .padding(.horizontal, 20)
            .transition(.move(edge: .bottom).combined(with: .opacity))
        }
        .background(Color.black.opacity(0.4).edgesIgnoringSafeArea(.all))
        .onTapGesture {
            isPresented = false
        }
    }
}


#Preview {
//    BottomAlertView()
}
