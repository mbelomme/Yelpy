//
//  ViewController.swift
//  Yelpy
//
//  Created by Memo on 5/21/20.
//  Copyright © 2020 memo. All rights reserved.
//

import UIKit
import AlamofireImage

class RestaurantsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // ––––– TODO: Add storyboard Items (i.e. tableView + Cell + configurations for Cell + cell outlets)
    // ––––– TODO: Next, place TableView outlet here
    @IBOutlet weak var tableView: UITableView!
    
    
    // –––––– TODO: Initialize restaurantsArray
    var restaurantsArray: [[String:Any?]] = []
    
    
    // ––––– TODO: Add tableView datasource + delegate
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        getAPIData()
        
        tableView.rowHeight = 150

    }
    
    
    // ––––– TODO: Get data from API helper and retrieve restaurants
    func getAPIData(){
        API.getRestaurants(){
            (restaurants) in guard let restaurants = restaurants
            else{
                return
            }
            print(restaurants)
            self.restaurantsArray = restaurants
            self.tableView.reloadData()
        }
    }
    
    
    // Protocol stubs
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurantsArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell") as! RestaurantCell
        let restaurant = restaurantsArray[indexPath.row]
        
        // Displays restaurant's name
        cell.restaurantLabel.text = restaurant["name"] as? String ?? ""
        
        // Displays type of food sold at restaurant
        let kind = restaurant["categories"] as? [[String:String]] ?? []
        cell.typeLabel.text = kind[0]["title"] as String?
        
        // Displays restaurant's telephone number
        cell.phoneLabel.text = restaurant["display_phone"] as? String
        
        // Displays number of reviews restaurant has
        let count = restaurant["review_count"] as? Int ?? 0
        cell.totalRatings.text = "\(count)"
        
        // Displays photo of restaurant
        if let imageUrlString = restaurant["image_url"] as? String {
            let imageURL = URL(string: imageUrlString)
            cell.restaurantImage.af.setImage(withURL: imageURL!)
        }
        
        // Displays rating
        let rating = restaurant["rating"] as? Double
      
        
        return cell
    }

}

// ––––– TODO: Create tableView Extension and TableView Functionality


