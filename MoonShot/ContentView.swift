//
//  ContentView.swift
//  MoonShot
//
//  Created by Brandon Glenn on 12/9/21.
//

import SwiftUI

struct ContentView: View {
    @State private var isGridView = true
    
    let astronauts: [String: Astronaut] = Bundle.main.decode(file: "astronauts.json")
    let missions: [Mission] = Bundle.main.decode(file: "missions.json")
    
    let columns = [GridItem(.adaptive(minimum: 150))]
    
    
    var body: some View {
        NavigationView {
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
            .navigationTitle("MoonShot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(isGridView ? "List" : "Grid") {
                        isGridView.toggle()
                    }
                }
            }
        }
        
    }
}
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            NavigationView {
            ContentView()
            }
        }
    }
    
    
    //struct ContentView_Previews_Dark: PreviewProvider {
    //
    //    static var previews: some View {
    //        ContentView()
    //            .preferredColorScheme(.dark)
    //    }
    //}
