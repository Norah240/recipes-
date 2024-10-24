//
//  newRecipe.swift
//  Recipes
//
//  Created by Norah mo on 18/04/1446 AH.
//
import SwiftUI
import PhotosUI

struct Recipe: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let ingredients: [Ingredient]
}

struct Ingredient: Identifiable {
    let id = UUID()
    var name: String
    var measurement: String
    var serving: Int
}

// IngredientPopup View for adding ingredients
struct IngredientPopup: View {
    @Binding var isPresented: Bool
    var onAddIngredient: (Ingredient) -> Void

    @State private var ingredientName: String = ""
    @State private var measurement: String = "🥄 Spoon"
    @State private var serving: Int = 1

    var body: some View {
        VStack(spacing: 15) {
            Text("Ingredient Name")
                .font(.headline)
                .foregroundColor(.white)
                .padding(.top)

            TextField("Ingredient Name", text: $ingredientName)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                .foregroundColor(.white)
                .padding(.horizontal)

            VStack {
                Text("Measurement")
                    .font(.headline)
                    .foregroundColor(.white)

                HStack {
                    Button(action: {
                        measurement = "🥄 Spoon"
                    }) {
                        Text("🥄 Spoon")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(measurement == "🥄 Spoon" ? Color.colorOrange2 : Color.gray)
                            .cornerRadius(8)
                            .foregroundColor(.white)
                    }
                    Button(action: {
                        measurement = "🥛 Cup"
                    }) {
                        Text("🥛 Cup")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(measurement == "🥛 Cup" ? Color.colorOrange2: Color.gray)
                            .cornerRadius(8)
                            .foregroundColor(.white)
                    }
                }
            }
            .padding(.horizontal)

            VStack {
                Text("Serving")
                    .font(.headline)
                    .foregroundColor(.white)

                HStack {
                    Stepper(value: $serving, in: 1...10) {
                        Text("\(serving)")
                            .font(.title2)
                            .foregroundColor(.white)
                    }
                    .frame(maxWidth: .infinity)

                    Text(measurement)
                        .padding()
                        .background(Color.colorOrange2)
                        .cornerRadius(8)
                        .foregroundColor(.white)
                }
            }
            .padding(.horizontal)

            HStack {
                Button(action: {
                    isPresented = false
                }) {
                    Text("Cancel")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.gray)
                        .cornerRadius(8)
                        .foregroundColor(.white)
                }

                Button(action: {
                    let newIngredient = Ingredient(name: ingredientName, measurement: measurement, serving: serving)
                    onAddIngredient(newIngredient)
                    isPresented = false
                }) {
                    Text("Add")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.colorOrange2)
                        .cornerRadius(8)
                        .foregroundColor(.white)
                }
            }
            .padding(.horizontal)

            Spacer()
        }
        .padding()
        .background(Color.black.edgesIgnoringSafeArea(.all))
        .frame(maxWidth: 300, maxHeight: 400)
        .cornerRadius(20)
        .shadow(radius: 10)
    }
}

// ImagePicker View for selecting an image
struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?

    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        config.selectionLimit = 1

        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)

            guard let provider = results.first?.itemProvider, provider.canLoadObject(ofClass: UIImage.self) else {
                return
            }

            provider.loadObject(ofClass: UIImage.self) { image, _ in
                DispatchQueue.main.async {
                    self.parent.selectedImage = image as? UIImage
                }
            }
        }
    }
}

// NewRecipeView for creating new recipes
struct NewRecipeView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var showImagePicker = false
    @State private var selectedImage: UIImage?
    @State private var recipeTitle: String = ""
    @State private var recipeDescription: String = ""
    @State private var showIngredientPopup = false
    @State private var ingredients: [Ingredient] = []
    
    var onSave: (Recipe) -> Void // Closure for saving the recipe

    var body: some View {
        ZStack {
            NavigationView {
                VStack(alignment: .center, spacing: 20) {
                    // Upload Photo Button
                    Button(action: {
                        showImagePicker = true
                    }) {
                        if let image = selectedImage {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        } else {
                            VStack(alignment: .center, spacing: 20.0) {
                                Image(systemName: "photo.badge.plus")
                                    .resizable()
                                    .frame(width: 80, height: 80)
                                    .foregroundColor(Color("ColorOrange2"))
                                Text("Upload Photo")
                                    .foregroundColor(Color("ColorOrange2"))
                                    .font(.headline)
                            }
                            .padding(.top, 90.0)
                        }
                    }
                    .padding()
                    .sheet(isPresented: $showImagePicker) {
                        ImagePicker(selectedImage: $selectedImage)
                    }

                    // Title Field
                    VStack(alignment: .leading) {
                        Text("Title")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        TextField("Title", text: $recipeTitle)
                            .padding()
                            .background(Color.gray.opacity(0.15))
                            .cornerRadius(8)
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal)

                    // Description Field
                    VStack(alignment: .leading) {
                        Text("Description")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        TextField("Description", text: $recipeDescription)
                            .padding()
                            .frame(height: 100.0)
                            .background(Color.gray.opacity(0.15))
                            .cornerRadius(8)
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal)

                    // Add Ingredient Button
                    HStack {
                        Text("Add Ingredient")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        Spacer()
                        Button(action: {
                            showIngredientPopup = true
                        }) {
                            Image(systemName: "plus")
                                .foregroundColor(Color("ColorOrange2"))
                                .font(.title)
                        }
                    }
                    .padding(.horizontal)

                    // Ingredient List
                    List {
                        ForEach(ingredients) { ingredient in
                            HStack {
                                // Serving amount on the left, styled in orange
                                Text("\(ingredient.serving)")
                                    .font(.system(size: 18, weight: .bold))
                                    .foregroundColor(Color("ColorOrange2"))
                                    .padding(.leading, 8)

                                // Ingredient name styled in white
                                Text(ingredient.name)
                                    .font(.system(size: 18, weight: .bold))
                                    .foregroundColor(Color("ColorOrange2"))
                                    .padding(.leading, 8)

                                Spacer()

                                // Measurement with orange background
                                Text(ingredient.measurement)
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(Color.white)
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 5)
                                    .background(Color("ColorOrange2"))
                                    .cornerRadius(8)
                            }
                            .padding(.vertical, 5) // Space out rows
                            .background(Color.gray.opacity(0.2)) // Gray background for the entire row
                            .cornerRadius(10) // Rounded corners for the row
                        }
                    }
                    .listStyle(PlainListStyle())
                    .frame(height: 200)
                    Spacer()
                }
                .padding()
                .background(Color.black.edgesIgnoringSafeArea(.all))
                .navigationBarTitle("New Recipe", displayMode: .large)
                .navigationBarItems(
                    leading: Button("Back") {
                        presentationMode.wrappedValue.dismiss()
                    }
                        .foregroundColor(Color("ColorOrange2")),
                    trailing: Button("Save") {
                        let newRecipe = Recipe(title: recipeTitle, description: recipeDescription, ingredients: ingredients)
                        onSave(newRecipe) // Call the onSave closure
                        presentationMode.wrappedValue.dismiss() // Dismiss the view
                    }
                        .foregroundColor(Color("ColorOrange2"))
                )
            }

            // Custom popup overlay
            if showIngredientPopup {
                Color.black.opacity(0.6)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        showIngredientPopup = false
                    }

                IngredientPopup(isPresented: $showIngredientPopup) { newIngredient in
                    ingredients.append(newIngredient)
                }
            }
        }
    }
}

struct NewRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        NewRecipeView { _ in }
    }
}
