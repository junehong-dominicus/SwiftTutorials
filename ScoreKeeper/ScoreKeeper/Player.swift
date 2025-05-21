//
//  Player.swift
//  ScoreKeeper
//
//  Created by June Hong on 2025-05-21.
//

import Foundation

//In Swift, `Identifiable` is a protocol that you can adopt in your custom types to provide a stable and unique identity for each instance. When a type conforms to `Identifiable`, it must have a property called `id` that uniquely distinguishes it from other instances. This is especially useful in SwiftUI, where views like `ForEach` rely on unique identifiers to efficiently update and manage collections of data.
//By making your data models conform to `Identifiable`, you help SwiftUI track changes, insertions, and deletions in lists or other dynamic views, ensuring smooth and predictable UI updates. Typically, the `id` property is of type `UUID` or another unique value, but it can be any type that conforms to `Hashable`.

struct Player: Identifiable {
    let id: UUID = UUID()
    
    var name: String
    var score: Int
}
