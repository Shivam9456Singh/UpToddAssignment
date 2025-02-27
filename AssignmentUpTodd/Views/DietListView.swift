//
//  MealListView.swift
//  AssignmentUpTodd
//
//  Created by Shivam Kumar on 26/02/25.
//

import SwiftUI


struct CircularProgressView : View {
    
    var progress : Int
    let total : Int
    
    var body : some View {
        let progressFraction = total > 0 ? Double(progress) / Double(total) : 0
        
        ZStack{
            VStack(alignment: .center) {
                Text("Status")
                    .font(.system(size: 10 , weight: .regular))
                
                Text("\(progress) of \(total)")
                    .font(.system(size: 12 , weight: .regular))
            }
            
            Circle()
                .stroke(
                    Color.gray.opacity(0.2),
                    lineWidth: 10
                )
            Circle()
                .trim(from: 0 , to : CGFloat(progressFraction))
                .stroke(
                    Color(red : 255/255 , green: 100/255 , blue: 115/255),
                    style: StrokeStyle(
                        lineWidth: 10,
                        lineCap: .round)
                )
                .rotationEffect(.degrees(-90))
        }
    }
}

struct DietSectionView: View {
    let diet: Diet
    @State var selectAll : Bool = false
    @ObservedObject var dietViewModel : DietViewModel
    @State var showAlert : Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            
            HStack(alignment: .top) {
                VStack(alignment: .leading){
                    
                    Text(diet.daytime) // Section title
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.primary)
                        .padding(.horizontal)
                    
                    Text(diet.timings)
                        .font(.system(size: 14 , weight: .medium))
                        .foregroundColor(.gray)
                        .padding(.horizontal)
                    
                    Button(action : {
                        selectAll.toggle()
                        showAlert.toggle()
                    }){
                        HStack(alignment: .center) {
                            Image("\(selectAll ? "selectedBoxImage" : "unselectedBoxImage")")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 19 , height: 19)
                            
                            Text("Select All")
                                .font(.system(size: 14 , weight: .bold))
                                .foregroundStyle(Color.black)
                            
                        }.padding(.horizontal)
                        
                    }.padding(.top , 10)
                    
                }.padding(.bottom , 20)
                
                Spacer()
                
                CircularProgressView(progress: diet.progressStatus.completed, total: diet.progressStatus.total)
                    .frame(width: 64 , height: 64)
                    .padding(.trailing, 30)
            }
          
            if diet.recipes.isEmpty {
                Text("No recipes available")
                    .foregroundColor(.gray)
                    .padding(.horizontal)
            } else {
                VStack(spacing: 15) {
                    ForEach(diet.recipes, id: \.id) { recipe in
                        CustomListCell(
                            selectAll : $selectAll,
                            mealTime: recipe.timeSlot,
                            imageName: recipe.image,
                            mealTitle: recipe.title,
                            durationTime: "\(recipe.duration) mins",
                            recipeID: recipe.id,
                            isFavourite: recipe.isFavorite,
                            isCompleted : recipe.isCompleted,
                            progressStatus: diet.progressStatus,
                            dietViewModel: dietViewModel,
                            showAlert: $showAlert
                        )
                        .padding(.horizontal)
                    }
                }
            }
        }
    }
}


struct DietListView: View {
    
    @StateObject var dietViewModel = DietViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            if dietViewModel.isLoading {
                ProgressView()
                    .frame(maxWidth: .infinity , maxHeight: .infinity, alignment: .center)
            } else if let errorMessage = dietViewModel.errorMessage {
                Text(errorMessage)
                    .foregroundStyle(Color.red)
                    .padding()
            }
            else{
                List {
                    ForEach(dietViewModel.dietData?.allDiets ?? [] , id : \.id){diet in
                        DietSectionView(diet : diet, dietViewModel: dietViewModel)
                    }.padding()
                }
            }
        }
        
    }
}

#Preview {
    DietListView()
}
