//
//  ContentView.swift
//  Recipes
//
//  Created by Norah mo on 17/04/1446 AH.
//

import SwiftUI

struct ContentView: View {
    @State private var isShowingNewRecipeView = false // State variable for navigation

    var body: some View {
        NavigationView {
            VStack {
                // Header
                HStack {
                    Text("Food Recipes")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding()
                        .frame(width: nil)
                    Spacer()
                    Button(action: {
                        isShowingNewRecipeView = true // Set the state to show new recipe view
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

                // Center Icon and Text
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
                        .frame(width: nil)
                }

                Spacer()
            }
            .background(Color.clear)
            .navigationTitle("") // Set an empty navigation title
            .navigationBarHidden(true) // Hide the navigation bar to keep UI clean
            .sheet(isPresented: $isShowingNewRecipeView) { // Present NewRecipeView as a sheet
                NewRecipeView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


