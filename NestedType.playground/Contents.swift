//: Playground - noun: a place where people can play

import UIKit

struct BlackjackCard {
    enum Suit: Character {
        case Spades = "a"
        case Hearts = "v"
        case Diamonds = "e"
        case Clubs = "d"
    }
    
    enum Rank: Int {
        case Two = 2
        case Three
        case Four
        case Five
        case Six
        case Seven
        case Eight
        case Nine
        case Ten
        case Jack
        case Queen
        case King
        case Ace
        
        struct Values {
            let first: Int
            let second: Int?
        }
        
        var values: Values {
            switch self {
            case .Ace:
                return Values(first: 1, second: 11)
            case .Jack, .Queen, .King:
                return Values(first: 10, second: nil)
            default:
                return Values(first: self.rawValue, second: nil)
            }
        }
    }
    
    let rank: Rank, suit: Suit
    var description: String {
        var output = "suit is \(suit.rawValue)."
        output += "value is \(rank.values.first)"
        if let second = rank.values.second {
            output += "or \(second)"
        }
        return output
    }
    
    
}
