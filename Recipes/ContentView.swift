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
                        .padding()
                    Spacer()
                    Button(action: {
                        isShowingNewRecipeView = true // Show NewRecipeView
                    }) {
                        Image(systemName: "plus")
                            .resizable()
                            .foregroundColor(Color(red: 0.985, green: 0.379, blue: 0.072))
                            .frame(width: 22.0, height: 22.0)
                            .font(.title)
                            .padding()
                    }
                }
                .frame(width: 414.0)
                .background(Color(red: 0.106, green: 0.106, blue: 0.106))
                .foregroundColor(.white)

                Spacer()

                if recipes.isEmpty {
                    // Show this if there are no recipes yet
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
                } else {
                    // List of saved recipes
                    List(recipes) { recipe in
                        VStack(alignment: .leading) {
                            Text(recipe.title)
                                .font(.headline)
                                .foregroundColor(.white)
                            Text(recipe.description)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        .listRowBackground(Color.black)
                    }
                    .listStyle(PlainListStyle())
                }

                Spacer()
            }
            .background(Color.black.edgesIgnoringSafeArea(.all))
            .sheet(isPresented: $isShowingNewRecipeView) {
                // Pass the closure to add a new recipe to the list
                NewRecipeView { newRecipe in
                    recipes.append(newRecipe)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
