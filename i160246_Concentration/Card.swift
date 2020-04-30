
import Foundation
struct Card
{
    var isFacedUp = false
    var isMatched = false
    var countSeen = 0
    var identifier: Int
    private static var identifierFactory = 0
    private static func getUniqueIdentifier () -> Int {
        identifierFactory += 1
        return Card.identifierFactory
    }
    init() {
        self.identifier = Card.getUniqueIdentifier()
	  countSeen = 0
    }
}
