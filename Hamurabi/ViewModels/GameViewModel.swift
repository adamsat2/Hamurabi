import Foundation
import Observation

@Observable
class GameViewModel {
    // MARK: Current Game State
    var year = 1
    var population = 100
    var acres = 1000
    var bushels = 2800
    
    // MARK: Previous Year Report ("Hamurabi: I beg to report...")
    var starved = 0
    var newcomers = 5
    var harvestPerAcre = 3
    var ratsAte = 200
    var landPrice = 19
    var plagueDeaths = 0
    
    // MARK: Game Over State
    var isGameOver = false
    var gameOverReason = ""
    var isVictory = false
    
    // MARK: Constants
    let maxYears = 10
    let bushelsToFeedOnePerson = 20
    let minimumStarvationPercentage = 0.45
    let plaguePercentage = 15
    let ratAttackChance = 10
    
    init() {
        startNewGame()
    }
    
    func startNewGame() {
        year = 1
        population = 100
        acres = 1000
        bushels = 2800
        starved = 0
        newcomers = 5
        harvestPerAcre = 3
        ratsAte = 200
        landPrice = Int.random(in: 17...26)
        plagueDeaths = 0
        isGameOver = false
        isVictory = false
    }
    
    func processLandTransaction(amount: Int, isBuying: Bool) {
        let actualAmount = isBuying ? amount : -amount
        acres += actualAmount
        bushels -= actualAmount * landPrice
    }

    func feedPeople(amount: Int) {
        bushels -= amount
        let peopleFed = amount / bushelsToFeedOnePerson
        starved = max(0, population - peopleFed)
        
        if starved > 0 {
            population -= starved
        }
        
        let starvationRate = Double(starved) / Double(population + starved)
        if starvationRate > minimumStarvationPercentage {
            endGame(reason: "You starved \(starved) people in one year! You heavy-handed bloodthirsty tyrant!", victory: false)
        }
    }

    func plantSeedsAndEndYear(amount: Int) {
        bushels -= amount
        year += 1
        calculateNextYear(plantedAcres: amount)
        
        if year > maxYears {
            calculateFinalScore()
        }
    }
    
    private func calculateNextYear(plantedAcres: Int) {
        // Plague (plaguePercentage chance)
        if Int.random(in: 1...100) <= plaguePercentage {
            plagueDeaths = population / 2
            population -= plagueDeaths
        } else {
            plagueDeaths = 0
        }
        
        // Harvest (1 to 5 bushels per acre)
        harvestPerAcre = Int.random(in: 1...5)
        let harvest = plantedAcres * harvestPerAcre
        bushels += harvest
        
        // Rats (ratAttackChance chance to eat 10-30% of crops)
        if Int.random(in: 1...100) <= ratAttackChance {
            let ratPercentage = Double(Int.random(in: 10...30)) / 100.0
            ratsAte = Int(Double(bushels) * ratPercentage)
            bushels -= ratsAte
        } else {
            ratsAte = 0
        }
        
        // Newcomers (Based on land/food availability relative to population)
        if population > 0 {
            newcomers = (20 * acres + bushels) / (100 * population) + 1
        } else {
            newcomers = 0
        }
        population += newcomers
        
        // Next year's land price
        landPrice = Int.random(in: 17...26)
    }
    
    private func endGame(reason: String, victory: Bool) {
        isGameOver = true
        gameOverReason = reason
        isVictory = victory
    }
    
    private func calculateFinalScore() {
        let acresPerPerson = population > 0 ? (acres / population) : 0
        
        if acresPerPerson < 10 {
            endGame(reason: "Your performance was mediocre. People survived, but did not thrive. You are a lazy ruler.", victory: false)
        } else {
            endGame(reason: "A fantastic ruler! You have expanded the kingdom greatly like a true Hamurabi.", victory: true)
        }
    }
}
