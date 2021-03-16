//
//  Codable.swift
//  iExpense
//
//  Created by George Patterson on 12/02/2021.
//

import SwiftUI

/*
 
 Userdefaults great for storing bools and ints but for more complex data structures like structs we need to use a codable protocol
 
 Codable protocol allows us to archive and unarchive data = converting objects into plain text and back again
 
 What we want ot be able to do is archive a CUSTOM TYPE so we can put it into UserDefaults and then unarchive it when it comes back out from userDefaults
 
 */

struct newUser: Codable {
    var firstName: String
    var lastName: String
}

struct Codables: View {
    
    @State private var user = newUser(firstName: "George", lastName: "Pat") //initialises a new instance of newUser with params
    
    
    var body: some View {
        //this button archives our user data to be saved in UserDefaults
        Button("Save User") {
            
            //We still need to tell swift when to archive and unarchive data
            //This new type takes something that conforms to Codable and send back that object in JavaScript Object Notation (JSON)
            
            let encoder = JSONEncoder()
            
            //we use the .encode on our JSON encoder to convert our user data into JSON data
            //we use try because it may not always be possible
            if let data = try? encoder.encode(self.user) {
                UserDefaults.standard.set(data, forKey: "UserData")
            }
            
            //to then decode the data we use the same format of the encoding
            
        }
    }
}

struct Codables_Previews: PreviewProvider {
    static var previews: some View {
        Codables()
    }
}
