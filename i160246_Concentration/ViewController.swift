
import UIKit
class ViewController: UIViewController {
    
    
    private lazy var Play = Concentration(numberOfPairsOfCards: pairs)
  
    @IBOutlet private weak var restartButton: UIButton!
    @IBOutlet private var cardButtons: [UIButton]!
   var pairs : Int {
         return (cardButtons.count+1)/2
     }
    @IBOutlet private weak var flipCountLabel: UILabel!
    @IBOutlet private weak var scoreLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction private func restartClicked(_ sender: UIButton) {
        Play.flips = 0
        Play.score = 0
        flipCountLabel.text = "Flips: \(Play.flips)"
        scoreLabel.text = "Score: \(Play.score)"
        Play = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
        emojiChoicesAnimals = ["🐶","🐱","🐯","🦅","🐼","🦊","🦕","🐔","🐻","🦄","🦇","🐴","🦁","🐒"]
       
        emojiChoicesSports = ["⚽️","🏀","🏈","⚾️","🥎","🎾","🏐","🏉","🥊","🎱","🏏","⛳️","🥅"]
        emojiChoicesCars = ["🚗","🚕","🚙","🚌","🚎","🏎","🚒","🚓","🚑","🚐","🚚","🚜"]
        emojiChoices = [emojiChoicesAnimals,emojiChoicesSports,emojiChoicesCars]
        emoji = [Int:String]()
        randomArray = Int(arc4random_uniform(UInt32(emojiChoices.count)))
    }
    private func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = Play.cards[index]
            if card.isFacedUp{
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }
            else{
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : emojiColorsButton[randomArray]
            }
        }
    }
    private func updateViewFromModelRestart() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            button.setTitle("", for: UIControl.State.normal)
            button.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
           }
    }
    
    @IBAction private func touchCard(_ sender: UIButton) {
           if let cardNumber = cardButtons.index(of: sender){
               Play.chooseCard(at: cardNumber)
               flipCountLabel.text = "Flips: \(Play.flips)"
               scoreLabel.text = "Score: \(Play.score)"
               updateViewFromModel()
           }
       }
    private var emojiColorsBackground = [#colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 1) , #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1) , #colorLiteral(red: 0.1294117719, green: 0.2156862766, blue: 0.06666667014, alpha: 1) , #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) , #colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1) , #colorLiteral(red: 0.3098039329, green: 0.2039215714, blue: 0.03921568766, alpha: 1) ]
    private var emojiColorsButton = [#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)  ,#colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1) , #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1), #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1) , #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1) , #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1) ]
    @IBOutlet weak var concentrationLabel: UILabel!
    
    private var emojiChoicesAnimals = ["🐶","🐱","🐯","🦅","🐼","🦊","🦕","🐔","🐻","🦄","🦇","🐴","🦁","🐒"]
    private var emojiChoicesSports = ["⚽️","🏀","🏈","⚾️","🥎","🎾","🏐","🏉","🥊","🎱","🏏","⛳️","🥅"]
    private var emojiChoicesCars = ["🚗","🚕","🚙","🚌","🚎","🏎","🚒","🚓","🚑","🚐","🚚","🚜"]
    
    private var emoji = [Int:String]()
    private lazy var randomArray = Int(arc4random_uniform(UInt32(emojiChoices.count)))
   private lazy var emojiChoices = [emojiChoicesAnimals,emojiChoicesSports,emojiChoicesCars]
   
    private func emoji(for card: Card) -> String
    {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices[randomArray].count)))  
            emoji[card.identifier] = emojiChoices[randomArray].remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
}

