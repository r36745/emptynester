//
//  Recipe.swift
//  emptynested
//
//  Created by Steven Roseman on 2/28/16.
//  Copyright © 2016 Steven Roseman. All rights reserved.
//

import Foundation
import UIKit

class Recipe {
    let title:String
    let recipeName:String
    let rating:Int
    
    init(title:String, recipe:String, rating:Int){
        self.title = title
        self.recipeName = recipe
        self.rating = rating
    }
    
    
    class func allRecipes() ->Array<Recipe> {
        return [Recipe(title: "Martha Stewart", recipe: "Baked Chicken", rating: 4),
                Recipe(title: "Paula Jones", recipe: "Meatloaf", rating: 5),
                Recipe(title: "Mommy Burris", recipe: "Jambalya", rating: 5),
                Recipe(title: "Brad Pitt", recipe: "BBQ Chicken", rating: 4),
                Recipe(title: "Paula Patton", recipe: "Ribs", rating: 5),
                Recipe(title: "Dasani", recipe: "Alfredo", rating: 3),
                Recipe(title: "Mike Mayock", recipe: "Party wings", rating: 4),
                Recipe(title: "Willie", recipe: "Lobster Bisque", rating: 5),
                Recipe(title: "Stephanie", recipe: "Pounding Pound Cake", rating: 5)]
    }
}