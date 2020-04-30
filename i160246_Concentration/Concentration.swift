
import Foundation
struct Concentration
{
    var flips: Int = 0
    var score : Int = 0
    private(set) var cards = [Card] ()
    
    mutating func chooseCard(at index: Int)  {
        assert(cards.indices.contains(index),"Concentration.chooseCard(at: \(index)): Choosen Index not in cards")
       if !cards[index].isMatched {
            if cards[index].isFacedUp == false {
                flips += 1
            }
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {			
		    cards[index].countSeen += 1
                if cards[matchIndex].identifier == cards[index].identifier {
                    score += 2
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                else {
                    if cards[matchIndex].countSeen > 1  {
                       score -= 1
                    }
                    if cards[index].countSeen > 1 {
                        score -= 1
                    }
                  }
                cards[index].isFacedUp = true
            }
            else{                
             cards[index].countSeen += 1
		     indexOfOneAndOnlyFaceUpCard = index
           }
        }
    }
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
           get {
               var foundIndex: Int?
               for index in cards.indices {
                   if cards[index].isFacedUp {
                       if foundIndex == nil {
                       foundIndex = index
                       }
                       else {
                           return nil
                       }
                   }
               }
               return foundIndex
           }
           set {
               for index in cards.indices {
                   cards[index].isFacedUp = (index == newValue )
               }
           }
       }
    
    init(
        numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards>0,"Concentration.init(at: \(numberOfPairsOfCards)): Should have at least one card")
        for _ in 1...numberOfPairsOfCards{
            let card = Card()
            cards += [card,card]
        }
        flips = 0
        score = 0
        cards.shuffle()
    }
}

