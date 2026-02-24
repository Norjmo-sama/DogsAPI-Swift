//
//  ContentView.swift
//  Dogs
//
//  Created by Molly Norman on 2/24/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: "https://images.dog.ceo/breeds/hound-english/n02089973_2331.jpg")) { img in
                if let error = img.error{
                    Text("We have an error!")
                    Text("\(error.localizedDescription)")
                }
                if let image = img.image {
                    image
                        .resizable()
                        .frame(width: 200, height: 200)
                }
            }
            Text("Maverick")
                .bold()
                .font(.largeTitle)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
    }
}

#Preview {
    ContentView()
}
