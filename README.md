This SwiftUI Recipe Management App allows users to create,
view, and manage their favorite recipes through a simple, intuitive interface. 
The main screen (ContentView) displays a list of recipes as cards,
each featuring the recipe title, description, and an optional image. 
Users can add new recipes by tapping the "+" button, which opens the NewRecipeView,
where they can enter details for a new recipe.
When a recipe is selected, a RecipeDetailView opens to show the recipe’s full details, 
including the description, image, and ingredients. 
Users can also delete recipes from this detailed view using a "Delete Recipe" button, 
which includes a confirmation prompt to prevent accidental deletions.
The app uses conditional views to handle cases where there are no saved recipes, 
displaying a NoRecipesView to encourage users to add their first recipe.
Each recipe card (RecipeCard) is designed to be visually appealing, 
with gradient overlays and an easy-to-read format. 
This project requires Xcode 12 or higher and Swift 5.3 or later.
It can be customized further by adjusting color themes,
adding fields to the Recipe model, 
or modifying the layout in the RecipeCard and RecipeDetailView components. 
here are a few screenshots if the app ui :
<img width="316" alt="Screenshot 1446-05-02 at 2 15 51 PM" src="https://github.com/user-attachments/assets/f4f0cab1-4106-4e5e-83c2-4fa4c01d72fa">

<img width="319" alt="Screenshot 1446-05-02 at 2 16 13 PM" src="https://github.com/user-attachments/assets/de505b05-5657-41e8-82d6-c631b4fe6a9c">

<img width="309" alt="Screenshot 1446-05-02 at 2 16 30 PM" src="https://github.com/user-attachments/assets/280a6ba8-b582-4e88-a60c-bc2bb7ec93e4">

