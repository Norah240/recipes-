Recipe App🫕

This SwiftUI-based app allows users to create, view, and manage recipes. The app features a list of recipes presented as cards, with the ability to add, view, and delete individual recipes.



Features

Add Recipes: Users can add new recipes by tapping the "+" button in the top-right corner.
Recipe List: Saved recipes appear as cards in a scrollable view. Each card displays the recipe title, description, and an image.
Detailed Recipe View: Tapping "See All" on a recipe card opens a detailed view, showing the recipe's full description, image, and list of ingredients.
Delete Recipes: Users can delete recipes from the detailed view with a confirmation prompt.



Project Structure💻

The app consists of the following main components:

ContentView: The main screen, showing a list of recipes in card format. This view includes navigation to add and view recipe details.
NoRecipesView: Displayed when there are no saved recipes. It encourages users to add their first recipe.
RecipeCard: The visual representation of a recipe on the main screen, including an image, title, description, and a "See All" button.
RecipeDetailView: A detailed view of a selected recipe, displaying its full information and a delete button.
Models: Recipe and Ingredient models represent the structure of each recipe and ingredient respectively.



Setup and Requirements📱

This project requires:

Xcode: Version 12 or higher
Swift: 5.3 or higher



here are a few screenshots if the app ui :



<img width="316" alt="Screenshot 1446-05-02 at 2 15 51 PM" src="https://github.com/user-attachments/assets/f4f0cab1-4106-4e5e-83c2-4fa4c01d72fa">

<img width="319" alt="Screenshot 1446-05-02 at 2 16 13 PM" src="https://github.com/user-attachments/assets/de505b05-5657-41e8-82d6-c631b4fe6a9c">

<img width="309" alt="Screenshot 1446-05-02 at 2 16 30 PM" src="https://github.com/user-attachments/assets/280a6ba8-b582-4e88-a60c-bc2bb7ec93e4">

