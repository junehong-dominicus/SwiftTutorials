//
//  ContentView.swift
//  ScoreKeeper
//
//  Created by June Hong on 2025-05-21.
//

import SwiftUI

struct ContentView: View {
//    @State private var players: [String] = ["Elisha", "Andre", "Jasmine"]
    // The code defines a property called `players` using Swift's `@State` property wrapper. This property is an array of strings, initialized with three names: "Elisha", "Andre", and "Jasmine". The `@State` attribute is specific to SwiftUI and is used to indicate that this property is a source of truth for data that can change over time within a view.
    // When a `@State` property like `players` is modified—such as adding or removing a player—SwiftUI automatically detects the change and updates the user interface to reflect the new state. This makes it easy to build interactive and dynamic views, since you don't need to manually trigger UI updates.
    // In summary, this line sets up a mutable list of player names that the view can display and update, with SwiftUI handling the UI refreshes whenever the list changes.
//    @State private var scores: [Int] = Array(repeating: 0, count: 3)
    
//    @State private var players: [Player] = [
//        Player(name: "Elisha", score: 0),
//        Player(name: "Andre", score: 0),
//        Player(name: "Jasmine", score: 0)
//    ]
    
    @State private var scoreboard = Scoreboard()
    @State private var startingPoints = 0
    
    var body: some View {
//        VStack {
        VStack(alignment: .leading) {
            Text("Score Keeper")
                .font(.title)
                .bold()
                .padding(.bottom)
            // This line uses SwiftUI’s `ForEach` view to create a dynamic list of views—one for each player in the `players` array. The range `0..<players.count` generates a sequence of integer indices from 0 up to (but not including) the number of players. For each index, the closure `{ index in ... }` is executed, allowing you to access and modify each player's name individually.
            // The `id: \.description` part tells SwiftUI how to uniquely identify each element in the sequence. Here, it uses the string description of each index as the identifier. While this works for simple cases, it’s generally safer to use the index itself (`id: \.self`) when iterating over a range of integers, as it avoids potential confusion and is more idiomatic.
            // Overall, this line sets up a loop that generates a view (like a `TextField`) for each player, making the UI automatically adjust as players are added or removed.
            
            SettingsView(doesHighestScoreWin: $scoreboard.doesHighestScoreWin, startingPoints: $startingPoints)
                .disabled(scoreboard.state != .setup)
            
            Grid{
                GridRow {
                    Text("Player")
                        .gridColumnAlignment(.leading)
                    Text("Score")
                }
                .font(.headline)
                
                ForEach($scoreboard.players) { $player in
                    GridRow {
                        HStack {
                            if scoreboard.winners.contains(player) {
                                Image(systemName: "crown.fill")
                                    .foregroundStyle(Color.yellow)
                            }
                            TextField("Name", text: $player.name)
                                .disabled(scoreboard.state != .setup)
                        }
                        Text("\(player.score)")
                            .opacity(scoreboard.state == .setup ? 0 : 1.0)
                        Stepper("\(player.score)", value: $player.score)
                            .labelsHidden()
                            .opacity(scoreboard.state == .setup ? 0 : 1.0)
                    }
                }
            }
            .padding(.vertical)
            // In SwiftUI, the dollar sign (`$`) before a variable like `players` creates a binding to that state property. A binding is a two-way connection between the data and the user interface, allowing changes in the UI to update the data and vice versa.
            // When you use `$players`, you are passing a binding to the entire `players` array. This is especially useful in SwiftUI views like `ForEach`, which can then create individual bindings for each element in the array. This enables child views or controls (such as `TextField` or `Stepper`) to directly modify the properties of each player, and those changes will automatically update the state in your main view.
            // In summary, `$players` exposes the `players` array as a binding, making it possible for SwiftUI to manage updates and keep the UI in sync with the underlying data.
            Button("Add Player", systemImage: "plus") {
                scoreboard.players.append(Player(name: "", score: 0))
            }
            .opacity(scoreboard.state == .setup ? 0 : 1.0)
            
            Spacer()
            
            HStack {
                Spacer()
                switch scoreboard.state {
                case .setup:
                    Button("Start Game", systemImage: "play.fill") {
                        scoreboard.state = .playing
                        scoreboard.resetScores(to: startingPoints)
                    }
                case .playing:
                    Button("End Game", systemImage: "stop.fill") {
                        scoreboard.state = .gameOver
                    }
                case .gameOver:
                    Button("Reset Game", systemImage: "arrow.counterclockwise") {
                        scoreboard.state = .setup
                    }
                }
                Spacer()
            }
            .buttonStyle(.bordered)
            .buttonBorderShape(.capsule)
            .controlSize(.large)
            .tint(.blue)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
