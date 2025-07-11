//
//  ContentView.swift
//  BirthdayApp
//
//  Created by Vaibhavi Bandaru on 7/11/25.
//

import SwiftUI

struct ContentView: View
{
    //variables:
    //@State refers to being able to update information?
    @State private var newName = ""
    @State private var newBirthday = Date.now
    
    //friends array
    @State private var friends: [Friend] = [Friend(name: "Vaibhavi", birthday: .now), Friend(name: "Sourish", birthday: .now)]
    
    var body: some View
    {
        
        NavigationStack
        {
            List(friends, id: \.name)
            {
                friend in
                HStack
                {
                    Text(friend.name)
                    Spacer()
                    Text(friend.birthday, format: .dateTime.month(.wide).day().year())
                }
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
                        friends.append(newFriend)
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
}

#Preview {
    ContentView()
}
