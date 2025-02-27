//
//  DishModel.swift
//  AssignmentUpTodd
//
//  Created by Shivam Kumar on 26/02/25.
//
import Foundation

// Top-level container
struct DietsResponse: Codable {
    let status: String
    let message: String
    let data: DietsData
}

// Data containing diets
struct DietsData: Codable {
    let diets: DietsContainer?
}

// Diets container
struct DietsContainer: Codable {
    let dietStreak: [String]
    let allDiets: [Diet]
}

// Each meal section
struct Diet: Codable, Identifiable {
    var id = UUID() 
    let daytime: String
    let timings: String
    let progressStatus: ProgressStatus
    let recipes: [Recipe]

    private enum CodingKeys: String, CodingKey {
        case daytime, timings, progressStatus, recipes
    }
}

// Progress tracking
struct ProgressStatus: Codable {
    let total: Int
    var completed: Int
}

// Individual recipe
struct Recipe: Codable, Identifiable {
    let id = UUID()
    let title: String
    let timeSlot: String
    let duration: Int
    let image: String
    let isFavorite: Int
    let isCompleted: Int
}
