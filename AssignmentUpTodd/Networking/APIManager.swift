//
//  APIManager.swift
//  AssignmentUpTodd
//
//  Created by Shivam Kumar on 26/02/25.
//

import Foundation

//class APIManager  : ObservableObject {
//    
//    @Published var dietApiData = [Meal]()
//    
//    func fetchDietData(){
//        guard let url = URL(string : "https://uptodd.com/fetch-all-diets") else { return }
//        
//        URLSession.shared.dataTask(with: url){data ,response , error in
//        
//            guard let data = data , error == nil else {
//                print("Error in fetching data :\(error?.localizedDescription ?? "Unknown Error")")
//                return
//            }
//            
//            do {
//                let decodedData = try JSONDecoder().decode(MealDishModel.self, from: data)
//                DispatchQueue.main.async{
//                    self.dietApiData = decodedData.
//                }
//                
//            }catch {
//                print("Decoding error :\(error)")
//            }
//        }.resume()
//    }
//    
//}
