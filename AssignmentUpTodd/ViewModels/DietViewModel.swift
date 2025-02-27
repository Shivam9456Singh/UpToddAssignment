//
//  MealViewModel.swift
//  AssignmentUpTodd
//
//  Created by Shivam Kumar on 26/02/25.
//

import Foundation

class DietViewModel : ObservableObject {
    @Published var dietData : DietsContainer?
    @Published var diets : [Diet] = []
    @Published var filteredRecipes : [Recipe] = []
    @Published var allRecipes : [Recipe] = []
    @Published var isLoading : Bool = true
    @Published var errorMessage : String?
    @Published var searchText : String = "" {
        didSet {
            filterRecipes()
        }
    }
   
    init(){
        fetchDietsData()
    }
    
    func fetchDietsData(){
        guard let url = URL(string : "https://uptodd.com/fetch-all-diets") else {
            errorMessage = "Invalid API endpoint"
            isLoading = false
            return
        }
        
        URLSession.shared.dataTask(with: url){data ,response , error in
            DispatchQueue.main.async{
                self.isLoading = false
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    self.errorMessage = "No data available."
                }
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(DietsResponse.self, from: data)
                DispatchQueue.main.async {
                    self.dietData = decodedData.data.diets
                    self.objectWillChange.send()
                    
                    self.dietData?.allDiets.forEach{diet in
                        diet.recipes.forEach{recipe in
                            print("Recipe Title: \(recipe.title) , timeSlot : \(recipe.timeSlot)")
                        }
                    }
                }
            }catch {
                DispatchQueue.main.async {
                    self.errorMessage = "Decoding Error : \(error.localizedDescription)"
                }
            }
            
        }.resume()
    }
    
    //MARK: - updating the isFavourite and isCompleted
    
    func toggleCompletion(for recipeId : UUID){
        updateDietStatus(recipeID: recipeId, field: "isCompleted")
    }
    
    func toggleFavourite(for recipeID : UUID){
        updateDietStatus(recipeID: recipeID, field: "isFavourite")
    }
    
    func updateDietStatus(recipeID : UUID , field : String){
        guard let url = URL(string: "https://uptodd.com/fetch-all-diets") else {return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body : [String : Any] = [
            "recipeID" : recipeID.uuidString,
            field : 1

        ]
        
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: body , options: [])
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error updating \(field): \(error.localizedDescription)")
                return
            }
            print("Successfully updated \(field).")
            
        }.resume()
    }
    
    //MARK: - method for converting the string timSlot into AM PM Format
    
    func convertToAMPM(timeSlot : String)->String {
        let inputFormatter = DateFormatter()
            inputFormatter.dateFormat = "HH:mm"
            
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "hh:mm a"
            
            if let date = inputFormatter.date(from: timeSlot) {
                return outputFormatter.string(from: date)
            } else {
                return "Invalid Time"
            }
    }
    
    func filterRecipes(){
        if searchText.isEmpty {
            filteredRecipes = allRecipes
        } else {
            filteredRecipes = allRecipes.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    
}
