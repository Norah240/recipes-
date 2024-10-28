//
//  ContentView.swift
//  Recipes
//
//  Created by Norah mo on 17/04/1446 AH.
//
import SwiftUI

// Main ContentView
struct ContentView: View {
    @State private var isShowingNewRecipeView = false // State variable for navigation
    @State private var recipes: [Recipe] = [] // Store the list of recipes
    @State private var selectedRecipe: Recipe? // State variable for the selected recipe

    var body: some View {
        NavigationView {
            VStack {
                // Header
                HStack {
                    Text("Food Recipes")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                        .padding()
                    Spacer()
                    Button(action: {
                        isShowingNewRecipeView = true // Show NewRecipeView
                    }) {
                        Image(systemName: "plus")
                            .resizable()
                            .foregroundColor(Color(red: 0.985, green: 0.379, blue: 0.072))
                            .frame(width: 22.0, height: 22.0)
                            .padding()
                    }
                }
                .frame(maxWidth: .infinity)
                .background(Color(red: 0.106, green: 0.106, blue: 0.106))

                // Conditional UI
                if recipes.isEmpty {
                    // Display this UI if there are no saved recipes
                    NoRecipesView()
                } else {
                    // Display the list of saved recipes
                    ScrollView {
                        VStack(spacing: 16) {
                            ForEach(recipes) { recipe in
                                RecipeCard(recipe: recipe, onSeeAll: {
                                    selectedRecipe = recipe // Set the selected recipe
                                })
                            }
                        }
                        .padding(.horizontal, 20.0)
                    }
                }

                Spacer()
            }
            .background(Color.black.edgesIgnoringSafeArea(.all))
            .sheet(isPresented: $isShowingNewRecipeView) {
                NewRecipeView { newRecipe in
                    recipes.append(newRecipe) // Add the new recipe to the list
                }
            }
            .sheet(item: $selectedRecipe) { recipe in
                RecipeDetailView(recipe: recipe, onDelete: {
                    deleteRecipe(recipe)
                })
            }
        }
    }

    private func deleteRecipe(_ recipe: Recipe) {
        print("Attempting to delete recipe with ID: \(recipe.id)")
        if let index = recipes.firstIndex(where: { $0.id == recipe.id }) {
            recipes.remove(at: index) // Remove the recipe
            selectedRecipe = nil // Dismiss the detail view
            print("Recipe deleted successfully.")
        } else {
            print("Recipe not found in the list.")
        }
    }
}

// View for when no recipes are saved
struct NoRecipesView: View {
    var body: some View {
        VStack {
            Image(systemName: "fork.knife.circle")
                .resizable()
                .frame(width: 325.0, height: 327.0)
                .foregroundColor(Color(red: 0.985, green: 0.379, blue: 0.072))
            
            Text("There’s no recipe yet")
                .font(.title)
                .foregroundColor(.white)
                .fontWeight(.bold)
                .padding(.top, 20)
            
            Text("Please add your recipes")
                .font(.body)
                .foregroundColor(.gray)
                .padding(.top, 5)
        }
        .padding()
    }
}

// Recipe Card View
struct RecipeCard: View {
    var recipe: Recipe
    var onSeeAll: () -> Void // Closure to handle "See All" button action

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            if let image = recipe.image { // Assuming `image` is a property of `Recipe`
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 400.0, height: 250)
                    .cornerRadius(10)
                    .clipped()
                    .overlay(
                        LinearGradient(
                            gradient: Gradient(colors: [Color.black.opacity(0.7), Color.clear]),
                            startPoint: .bottom,
                            endPoint: .center
                        )
                        .cornerRadius(10)
                    )
            }

            VStack(alignment: .leading, spacing: 6) {
                Text(recipe.title)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)

                Text(recipe.description)
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .lineLimit(2)

                Button(action: onSeeAll) { // Use the closure here
                    Text("See All")
                        .font(.subheadline)
                        .foregroundColor(Color(red: 0.985, green: 0.379, blue: 0.072))
                        .padding(.top, 5)
                }
            }
            .padding(16)
        }
        .padding(.bottom, 20) // Add space below each card
    }
}

// Recipe Detail View

import SwiftUI

struct RecipeDetailView: View {
    var recipe: Recipe
    var onDelete: () -> Void // Closure to handle delete action
    
    @State private var showDeleteConfirmation = false // State variable to control the alert

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                // Title
                Text(recipe.title)
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.horizontal)
                    .padding(.top, 20)
                
                Divider()
                    .background(Color.gray.opacity(0.5))
                    .padding(.horizontal)
                
                // Recipe Image with Bottom Shadow
                ZStack(alignment: .bottom) {
                    if let image = recipe.image {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(height: 300)
                            .clipped()
                            .cornerRadius(15)
                            .padding(.horizontal)
                            .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 5)
                    }
                    
                    // Bottom Gradient Shadow Overlay
                    LinearGradient(
                        gradient: Gradient(colors: [Color.black.opacity(0.6), Color.clear]),
                        startPoint: .bottom,
                        endPoint: .top
                    )
                    .frame(height: 100) // Adjust height for shadow effect
                    .cornerRadius(10)
                    .padding(.horizontal)
                }
                
                // Recipe Description
                Text(recipe.description)
                    .font(.system(size: 16))
                    .foregroundColor(.gray)
                    .padding(.horizontal)
                
                // Ingredients Section Title
                Text("Ingredients")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.horizontal)
                    .padding(.top, 8)
                
                // Ingredients List
                VStack(spacing: 12) {
                    ForEach(recipe.ingredients) { ingredient in
                        HStack {
                            Text("\(ingredient.serving)")
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(Color("ColorOrange2"))
                                .frame(width: 40, alignment: .leading)
                            
                            Text(ingredient.name)
                                .font(.system(size: 18))
                                .foregroundColor(Color("ColorOrange2"))
                            
                            Spacer()
                            
                            Text(ingredient.measurement)
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(Color.white)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(Color("ColorOrange2"))
                                .cornerRadius(8)
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                        .shadow(color: Color.black.opacity(0.15), radius: 5, x: 0, y: 4)
                    }
                }
                .padding(.horizontal)
                .padding(.top, 5)
                
                Spacer()
                
                // Delete Recipe Button with Grey Background
                Button(action: {
                    showDeleteConfirmation = true // Show confirmation alert
                }) {
                    Text("Delete Recipe")
                        .font(.headline)
                        .foregroundColor(.red)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                        .shadow(color: Color.black.opacity(0.15), radius: 5, x: 0, y: 4)
                        .padding(.horizontal)
                }
                .padding(.bottom, 20)
                .alert(isPresented: $showDeleteConfirmation) {
                    Alert(
                        title: Text("Confirm Delete"),
                        message: Text("Are you sure you want to delete this recipe?"),
                        primaryButton: .destructive(Text("Delete")) {
                            onDelete() // Call the delete action if confirmed
                        },
                        secondaryButton: .cancel()
                    )
                }
            }
            .background(Color.black)
            .cornerRadius(20)
            .padding()
        }
        .background(Color.black.edgesIgnoringSafeArea(.all))
    }
}
// Preview Provider
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

