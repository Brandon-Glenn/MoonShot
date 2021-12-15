//
//  MissionView.swift
//  MoonShot
//
//  Created by Brandon Glenn on 12/13/21.
//

import SwiftUI

struct MissionView: View {
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }
    
    let crew: [CrewMember]
    
    let mission: Mission
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geometry.size.width * 0.6)
                        .padding(.top)
                
                    
                    VStack(alignment: .leading) {
                        SimpleDivider()

                        Text("Mission Highlights")
                            .font(.title.bold())
                            .padding(.bottom, 5)
                        
                        Text(mission.description)
                        SimpleDivider()
                        
                        Text("Crew")
                            .font(.title.bold())
                            .padding(.bottom, 5)
                        
                        
                    }
                    .padding(.horizontal)
                }
                .padding(.bottom)
                

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(crew, id: \.role) {  crewMember in
                            NavigationLink {
                                AstronautView(astronaut: crewMember.astronaut)
                            } label: {
                                HStack {
                                    Image(crewMember.astronaut.id)
                                        .resizable()
                                        .frame(width: 104, height: 72)
                                        .clipShape(Capsule())
                                        .overlay(
                                            Capsule()
                                                .strokeBorder(.white, lineWidth: 1)
                                        )

                                    VStack(alignment: .leading)  {

                                        Text(crewMember.astronaut.name)
                                            .foregroundColor(.white)
                                            .font(.headline)
                                        Text(crewMember.role)
                                            .foregroundColor(.secondary)
                                    }
                                    
                                }
                                .padding(.horizontal)
                            }
                        }
                    }
                }
            }
            .navigationTitle(mission.displayName)
            .navigationBarTitleDisplayMode(.inline)
            .background(.darkBackground)
        }
    }
    
    init(mission:Mission, astronauts: [String:Astronaut]) {
        self.mission = mission
        // for each crewMember in missions.json - search for match in astronauts.json
        self.crew = mission.crew.map{ member in
            // search astronauts dictionary for astronaut name
            if let astronaut = astronauts[member.name] {
                return CrewMember(role: member.role, astronaut: astronaut)
                
            } else {
                fatalError("Mission \(member.name)")
            }
        }
    }
}


struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode(file: "missions.json")
    static let astronauts: [String: Astronaut] = Bundle.main.decode(file: "astronauts.json")

    static var previews: some View {
        MissionView(mission: missions[0], astronauts: astronauts)
            .preferredColorScheme(.dark)
.previewInterfaceOrientation(.portrait)
    }
}

struct SimpleDivider: View {
    var body: some View {
        Rectangle()
            .frame (height: 2)
            .foregroundColor(.lightBackground)
            .padding(.vertical)
    }
}
