//
//  SwiftUIView.swift
//  AssignmentUpTodd
//
//  Created by Shivam Kumar on 25/02/25.
//

import SwiftUI

struct HomeView: View {
    @State private var showAlert : Bool = false
    @StateObject var dietViewModel = DietViewModel()
    
    var body: some View {
        
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    Image("backArrowButton")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 32 , height: 32 , alignment: .leading)
                        .padding(.leading , 10)
                    
                    HStack(alignment: .center) {
                        VStack (alignment: .center, spacing: 5){
                            Text("Everyday Diet Plan")
                                .padding(.leading, 16)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.system(size: 20, weight: .semibold))
                            Text("Track Ananya's every meal")
                                .padding(.leading, 16)
                                .font(.system(size: 14 , weight: .regular))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                
                        }
                        VStack(alignment: .center , spacing: 5) {
                            Image("cartButton")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 44, height: 44, alignment: .trailing)
                                .padding(.trailing, 20)
                            
                            Text("Grocery List")
                                .font(.system(size: 12))
                                .padding(.trailing , 20)
                        }
                       
                    }
                    .padding(.top , 50)
                    
                }
                
                DietStreakSection()
                    .padding()
                
                SearchBarView(searchText: $dietViewModel.searchText)
                    .padding()
              
                ForEach(dietViewModel.dietData?.allDiets ?? [] , id : \.id){diet in
                    DietSectionView(diet : diet , dietViewModel: dietViewModel)
                }.padding()
                
                    
            }
            .frame(maxWidth: .infinity , maxHeight: .infinity)
            .overlay {
                if showAlert {
                    BottomAlertView(isPresented: $showAlert) {
                        
                        showAlert = false
                        
                    }
                }
            }
            
    
            
        }
        .scrollIndicators(.hidden)
        
    }
}

#Preview {
    HomeView()
}
