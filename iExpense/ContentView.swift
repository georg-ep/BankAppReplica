//
//  ContentView.swift
//  iExpense
//
//  Created by George Patterson on 11/02/2021.
//

import SwiftUI

/*
 
 @State only works with structs.
 When we try to use it in a class, it doesn't work so instead, we need to use @ObservedObject as the property wrapper
 
 
Class usage.
1. Make a class which conforms to ObservableObject protocol
2. Mark some properties in the class with the @Published so that any views using the class get updated when the values change
3. Create an instance of our class with the @ObservableObject property wrapper
 
 The end result is that we can have our state stored in an external object, and we can now use that object in multiple views and have them all point to the same values.
 
 */

class User: ObservableObject {
    @Published var fname = "George"
    @Published var sname = "Patterson"
}



struct ContentView: View {
    
    @State private var numbers = [Int]()
    @State private var currentNumber = 1
    
    @State private var tapCount = UserDefaults.standard.integer(forKey: "Tap")
    
    @State private var showingSheet = false
    @ObservedObject var user = User()
    
    var body: some View {

        Text("")
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //creating a sheet
    func sheets() -> some View {
        var body: some View {
            VStack {
                Button("Show your name") {
                    self.showingSheet.toggle()
                }.padding(50)
                            
                TextField("Enter Your first name", text: $user.fname)
                TextField("Enter Your second name", text: $user.sname)

            }
            .sheet(isPresented: $showingSheet) { //presents the view when showingSheet = true
                SecondView(fname: user.fname, sname: user.sname)
                //initialises the view with user fname and sname
            }
        }
        
        return body
    }
    
    func deletingRows() -> some View {
        var body: some View  {
            NavigationView {
                VStack {
                    List{
                        ForEach(numbers, id: \.self) {
                            Text("\($0)")
                        }.onDelete(perform: removeRows) //calls remove rows when we decide to delete a specific row
                    }
                    Button("Add Number") {
                        self.numbers.append(self.currentNumber)
                        self.currentNumber += 1
                    }
                }
            }
            .navigationBarItems(leading: EditButton())
            //this modifier adds an edit button to delete multiple rows at the same time. Has to be wrapped in a navigation view
        }
        
        //to make onDelete work we need to implement a method which will receive a single parameter of type IndexSet
        //tells us the position of items in IndexSet which should be removed
        
        func removeRows(at offfests: IndexSet) {
            numbers.remove(atOffsets: offfests) //removes the text at a specific row in the list
        }
        return body
    }
    
    func storingUserDefaults() -> some View {
        
        //User Defaults saves user settings and important data
        
        //our tapCOunt is set to this above in order to read the data for the key Tap
        //@State private var tapCount = UserDefaults.standard.integer(forKey: "Tap")

        //allows us to exit the app and come back to it by saving tapcount data
        
        //userdefaults is best for storing simple data like booleans and ints
        //for more complex data we use
        
        Button("Tap count \(tapCount)") {
            UserDefaults.standard.set(self.tapCount, forKey: "Tap")
            self.tapCount += 1
        }
    }
    
}

//creates a view with fname and sname params with body of the view
struct SecondView: View {
    
    @Environment(\.presentationMode) var presentationMode
    //@Environment allows us to create properties that store values provided to us externally
    //presentationMode of a view contains 2 pieces of data:
    //1. is the view currently presented on screen?
    //2. a method to let us dismiss the view.
    
    let fname: String
    let sname: String
    
    var body: some View {
        Text("Hello \(fname) \(sname)")
        Button("Dismiss"){
            self.presentationMode.wrappedValue.dismiss() //this allows the view to be dismissed on the button click
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
