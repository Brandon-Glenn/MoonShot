//
//  ContentView.swift
//  MoonShot
//
//  Created by Brandon Glenn on 12/9/21.
//

import SwiftUI

struct ContentView: View {
    @State private var showingGrid = false
    
    let astronauts: [String: Astronaut] = Bundle.main.decode(file: "astronauts.json")
    let missions: [Mission] = Bundle.main.decode(file: "missions.json")
    
    var body: some View {
        NavigationView {
            
            Group {
                if showingGrid {
                    GridLayout( missions: missions, astronauts: astronauts)
                } else {
                    ListLayout( missions: missions, astronauts: astronauts)
                }
            }
            .navigationTitle("MoonShot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(showingGrid ? "List" : "Grid") {
                        showingGrid.toggle()
                    }
                }
            }
        }
        
    }
}
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
    
//---------------------------------------------------------------------------

struct GridLayout: View {
    let missions: [Mission]
    let astronauts: [String:Astronaut]
    
    let columns = [GridItem(.adaptive(minimum: 150))]

    var body: some View {
        ScrollView {
            LazyVGrid (columns: columns)  {
                ForEach (missions) { mission in
                    NavigationLink {
                        MissionView(mission: mission, astronauts: astronauts)
                    } label: {
                        VStack {
                            Image(mission.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .padding()
                            
                            VStack {
                                Text(mission.displayName)
                                    .font(.headline)
                                    .foregroundColor(.white)
                                Text(mission.formattedLaunchDate)
                                    .font(.caption)
                                    .foregroundColor(.white.opacity(0.5))
                                
                            }
                            .padding(.vertical)
                            .frame(maxWidth: .infinity)
                            .background(.lightBackground)
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.lightBackground)
                        )
                    }
                }
            }
            .padding([.horizontal,.bottom])
        }

    }
}

//---------------------------------------------------------------------------
struct ListLayout: View {
    
    let missions: [Mission]
    let astronauts: [String:Astronaut]
    
    var body: some View {
        List {
            ForEach(missions) { mission in
                HStack( spacing: 10) {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                    Text(mission.displayName)
                        .font(.headline)
                }
            }
        }
        
        
    }
}
