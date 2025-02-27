//
//  DietStreakView.swift
//  AssignmentUpTodd
//
//  Created by Shivam Kumar on 26/02/25.
//

import SwiftUI

struct DietStreakSection: View {
    
    @StateObject private var viewModel = DietViewModel()
   
    
    let mealTimes : [String] = [
        "morningStreakImage",
        "afterNoonStreakImage",
        "eveningStreakImage",
        "nightStreakImage",
    ]
    
    var body: some View {
        VStack (alignment: .leading) {
            
            HStack{
                Text("Diet Streak")
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Spacer()
                
                HStack(alignment: .center){
                    Image("dietStreakIcon")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 15 , height: 16.86)
                    Text("\(viewModel.dietData?.dietStreak.count ?? 0) Streak")
                        .font(.system(size: 14, weight: .light))
                        
                        
                }
                .padding(5)
                .background(Color.white)
                .border(.black)
                .clipShape(RoundedRectangle(cornerRadius: 25.0 , style: .continuous))
                .overlay {
                    RoundedRectangle(cornerRadius: 25.0 , style: .continuous)
                        .stroke(Color.black)
                }
                
            }
           
            if viewModel.isLoading {
                ProgressView()
                    .frame(maxWidth: .infinity)
            }
            else if let errorMessage = viewModel.errorMessage{
                Text(errorMessage)
                    .foregroundStyle(Color.red)
                    .frame(maxWidth: .infinity)
            }
            else{
                HStack(alignment: .center) {
                    let streaks = viewModel.dietData?.dietStreak ?? []
                    
                    ForEach(Array(streaks.enumerated()), id: \.offset) { index, streak in
                                            let imageName = index < mealTimes.count ? mealTimes[index] : "morningStreakImage"
                        MealStreakView(mealName: streak.capitalized(with: .autoupdatingCurrent), imageName: imageName)
                                        }
                }
                .padding(.top, 10)
                .frame(maxWidth: .infinity)
                
            }
            
        }
        .padding()
        .background(Color(red: 229/255, green: 245/255, blue: 189/255 , opacity: 0.4))
        .clipShape(RoundedRectangle(cornerRadius: 10.0 , style: .continuous))
    }
}

struct MealStreakView : View {
    let mealName : String
    let imageName : String
    
    var body : some View {
        VStack(alignment: .center , spacing: 5) {
            Text(mealName)
                .font(.system(size: 12))
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 40)
        }.padding(.horizontal , 10)
    }
}

#Preview {
    DietStreakSection()
}
