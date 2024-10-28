//
//  ContentView.swift
//  Recipes
//
//  Created by Norah mo on 17/04/1446 AH.
//
import SwiftUI

struct ContentView: View {
    @State private var isShowingNewRecipeView = false // State variable for navigation
    @State private var recipes: [Recipe] = [] // Store the list of recipes

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
                                RecipeCard(recipe: recipe)
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

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Image("hallomi") // Replace with actual recipe image if available
                .resizable()
                .scaledToFill()
                .frame(height: 250)
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

            VStack(alignment: .leading, spacing: 6) {
                Text(recipe.title)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)

                Text(recipe.description)
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .lineLimit(2)

                Button(action: {
                    // Action for "See All" or navigate to recipe detail
                    print("See All tapped for \(recipe.title)")
                }) {
                    Text("See All")
                        .font(.subheadline)
                        .foregroundColor(Color("ColorOrange2"))
                        .padding(.top, 5)
                }
            }
            .padding(16)
        }
        .padding(.bottom, 20) // Add space below each card
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
