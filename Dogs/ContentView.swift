//
//  ContentView.swift
//  Dogs
//
//  Created by Molly Norman on 2/24/26.
//

//Your challenge - Get the photo to load on application start
// And Make it look professional!

import SwiftUI

struct ContentView: View {
    @State var doggoImage: URL?
    var body: some View {
        VStack(spacing: 25) {
            AsyncImage(url: doggoImage) { img in
                if let error = img.error {
                    Text("We have an error!")
                    Text("\(error.localizedDescription)")
                }
                else if let image = img.image {
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 250, height: 250)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .shadow(radius: 8)
                }
            }
            
            Text("Our Dog?")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Button {
                Task {
                    await loadDog()
                }
            } label: {
                Text("New Dog")
                    .font(.headline)
                    .frame(width: 200, height: 50)
                    .cornerRadius(15)
                    .shadow(radius: 5)
            }
            
        }.padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        
        
        .task {
            await loadDog()
        }
        
    }
    
    func loadDog() async {
        let ourData = await getServerData()
        if let ourData = ourData {
            doggoImage = URL(string: ourData.message)
        }
    }
    
    
    
    func getServerData() async -> ServerResponse? {
        do {
            guard let serverURL = URL(string: "https://dog.ceo/api/breeds/image/random") else {
                return nil
            }
            let (data, response) = try await URLSession.shared.data(from: serverURL)
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Bad status code")
                return nil
            }
            let decoded = try JSONDecoder().decode(ServerResponse.self, from: data)
            
            return decoded
            
        }
        catch {
            print(error)
        }
        
        return nil
    }
}


#Preview {
    ContentView()
}

struct ServerResponse: Codable {
    let message: String
    let status: String
}
