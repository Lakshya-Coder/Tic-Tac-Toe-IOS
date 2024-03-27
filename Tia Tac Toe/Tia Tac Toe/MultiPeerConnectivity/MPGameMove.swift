//
//  MPGameMove.swift
//  Tia Tac Toe
//
//  Created by Lakshya Seth on 24/03/24.
//

import Foundation

struct MPGameMove: Codable {
    enum Action: Int, Codable {
        case start, move, reset, end
    }
    
    let action: Action
    let playerName: String?
    let index: Int?
    
    func data() -> Data? {
        try? JSONEncoder().encode(self)
    }
}
