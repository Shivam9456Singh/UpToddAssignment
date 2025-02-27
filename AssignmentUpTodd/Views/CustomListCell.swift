//
//  CustomListCell.swift
//  AssignmentUpTodd
//
//  Created by Shivam Kumar on 27/02/25.
//

import SwiftUI


struct CustomListCell : View  {
    @Binding var selectAll : Bool
    let mealTime : String
    let imageName : String
    let mealTitle : String
    let durationTime : String
    let recipeID: UUID
    @State var isFavourite : Int
    @State var isCompleted : Int
    @State var progressStatus : ProgressStatus
    @ObservedObject var dietViewModel: DietViewModel
    @Binding var showAlert : Bool
    
    
    var body : some View {
        let mealTimeWithAMPM = dietViewModel.convertToAMPM(timeSlot: mealTime)
        
        VStack(alignment: .leading) {
            if selectAll {
                HStack (alignment: .top) {
                    Image("selectedBoxImage")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 19.5 ,height: 19.5)
                    
                    Text("\(mealTimeWithAMPM)")
                        .font(.system(size: 16, weight: .medium))
                }
            }
            else{
                Text("\(mealTimeWithAMPM)")
                    .font(.system(size: 16, weight: .medium))
            }
          
            
            VStack {
                HStack(alignment: .top) {
                    AsyncImage(url: URL(string : imageName)) { image in
                       image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 109 , height: 114)
                            .clipped()
                            .cornerRadius(10)
                        
                    }placeholder: {
                        ProgressView()
                    }
                    
                    VStack (alignment: .leading){
                        HStack {
                            Text("\(mealTitle)")
                                .font(.system(size: 14, weight: .medium))
                            
                            Spacer()
                            Button(action : {
                                isFavourite = isFavourite == 0 ? 1 : 0
                                dietViewModel.toggleFavourite(for: recipeID)
                            }){
                                Image(systemName: "\(isFavourite == 0 ? "heart" : "heart.fill")")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 17.44 , height: 16)
                                    .foregroundStyle(Color(red : 76/255 , green : 88/255, blue : 217/255))
                            }
                        }
                        
                        
                        Spacer()
                        
                        HStack {
                            Image("clockImage")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 12 , height: 12)
                            
                            Text("\(durationTime)")
                                .font(.system(size: 10))
                                .frame(alignment: .leading)
                        }
                        .padding(.horizontal,2)
                        .frame(alignment: .leading)
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                        
                        Divider()
                        
                        HStack {
                            Button(action : {
                                isCompleted = isCompleted == 0 ? 1 : 0
                                dietViewModel.toggleCompletion(for: recipeID)
                                progressStatus.completed += isCompleted == 1 ? 1 : -1
                            }){
                                HStack {
                                    Image("customizeButtonImage")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 13.33, height: 13.33)
                                    
                                    Text("Customize")
                                        .font(.system(size: 14 ,weight: .medium))
                                }
                                .padding(.horizontal , 2)
                                .foregroundStyle(Color.white)
                                .frame(width: 100, height: 28, alignment: .center)
                                .background(Color(red : 76/255 , green : 88/255, blue : 217/255))
                                .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                            }
                            
                            Button(action :{
                                isCompleted = isCompleted == 0 ? 1 : 0
                                dietViewModel.toggleCompletion(for: recipeID)
                            }){
                                HStack {
                                    Image("\(isCompleted  == 0 ? "fedButtonImage" : "fedCompletedButtonImage")")
                                        .renderingMode(.original)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 13.33, height: 13.33)
                                    
                                    Text("\(isCompleted == 0 ? "Fed?" : "Fed")")
                                        .font(.system(size: 14 ,weight: .medium))
                                }
                                .foregroundStyle(Color(red : 76/255 , green : 88/255, blue : 217/255))
                                .frame(width: 100, height: 28, alignment: .center)
                                .background(Color.clear)
                                .clipShape(RoundedRectangle(cornerRadius: 25.0 , style: .continuous))
                                .overlay {
                                    RoundedRectangle(cornerRadius: 25.0 , style: .continuous)
                                        .stroke(Color(red : 76/255 , green : 88/255, blue : 217/255))
                                }
                                 
                            }
                        }
                        
                    }
                    
                    
                }.padding()
                
            }
            .frame(width: 343 , height: 130)
            .background(Color(red: 245/255, green: 242/255, blue: 255/255 , opacity: 1))
            .clipShape(RoundedRectangle(cornerRadius: 10.0 , style: .continuous))
            .overlay {
                selectAll ? RoundedRectangle(cornerRadius: 10.0, style: .continuous)
                    .stroke(Color(red : 206/255 , green : 194/255 , blue: 255/255)) : nil
                
                
            }
            .overlay {
                if showAlert {
                    BottomAlertView(isPresented: $showAlert) {
                        
                        dietViewModel.toggleCompletion(for: recipeID)
                        
                    }
                }
            }
            
        }
        .background(Color.clear)
    }
}

#Preview {
//    CustomListCell(mealTime: "6 AM" , imageName: "listImage" , mealTitle: "Peach Rice Pudding" , durationTime: "30 mins" , isFavourite: 1, isCompleted: 1, progressStatus: .init(total: 1, completed: 1))
}
