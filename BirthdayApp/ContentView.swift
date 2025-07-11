//
//  ContentView.swift
//  BirthdayApp
//
//  Created by Vaibhavi Bandaru on 7/11/25.
//

import SwiftUI
import SwiftData

struct ContentView: View
{
    //variables:
    //@State refers to being able to update information?
    @State private var newName = ""
    @State private var newBirthday = Date.now
    
    //friends array
    @Query private var friends: [Friend]
    
    /*.modelContainer modifier added to ContentView in the BirthdaysAppApp file inserts a modelContext into the SwiftUI environment, and that modelContext is accessible to all views under the container.
     
        Allows the model container (which holds the swiftData) to be accessible in all the views and all files?
     */
    @Environment(\.modelContext) private var context
    
    
    var body: some View
    {
        
        NavigationStack
        {
            List
            {
                ForEach(friends)
                {
                    friend in
                    HStack
                    {
                        Text(friend.name)
                        Spacer()
                        Text(friend.birthday, format: .dateTime.month(.wide).day().year())
                    }
                }
                .onDelete(perform: deleteFriend)
            }
            .navigationTitle("Birthdays")
            
            //going to move New Birthdays UI to the bottom?
            .safeAreaInset(edge: .bottom)
            {
                VStack (alignment: .center, spacing: 20)
                {
                    Text("New Birthday")
                        .font(.headline)
                    DatePicker(selection: $newBirthday, in: Date.distantPast...Date.now, displayedComponents: .date)
                    {
                        TextField("Name", text: $newName)
                            .textFieldStyle(.roundedBorder)
                            .padding(.horizontal)
                        
                    }
                    
                    Button("Save")
                    {
                        let newFriend = Friend(name: newName, birthday: newBirthday)
                        context.insert(newFriend)
                        newName = ""
                        newBirthday = .now
                    }
                    .bold()
                }
                .padding()
                .background(.bar)
            }
        }
    }
    
    func deleteFriend(at offsets: IndexSet)
    {
        for index in offsets
        {
            let friendToDelete = friends[index]
            context.delete(friendToDelete)
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Friend.self, inMemory: true)
}
