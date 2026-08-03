import Foundation
import Observation

@Observable
class GameViewModel {
    // MARK: Current Game State
    var year = 1
    var population = 100
    var acres = 1000
    var bushels = 2800
    var survivedPlagueThisGame = false
    var maxHarvestThisGame = 0
    
    // MARK: Previous Year Report
    var starved = 0
    var newcomers = 5
    var harvestPerAcre = 3
    var ratsAte = 200
    var landPrice = 19
    var plagueDeaths = 0
    
    // MARK: Game Over State
    var isGameOver = false
    var gameOverReason = ""
    var gameOverImage = ""
    var isVictory = false
    
    var totalStarvationPercentage: Double = 0.0
    
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
        totalStarvationPercentage = 0.0
        survivedPlagueThisGame = false
        maxHarvestThisGame = 0
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
            totalStarvationPercentage += starvationRate
            
            // Game Over (lose as The National Fink)
            if starvationRate > minimumStarvationPercentage {
                endGame(
                    reason: "You starved \(starved) people in one year! Due to this extreme mismanagement, you have not only been impeached and thrown out of office, but you have also been declared a national fink.",
                    image: "image_fink",
                    victory: false
                )
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
        if plagueDeaths > 0 { survivedPlagueThisGame = true }
        
        // Harvest (1 to 5 bushels per acre)
        harvestPerAcre = Int.random(in: 1...5)
        if harvestPerAcre > maxHarvestThisGame { maxHarvestThisGame = harvestPerAcre }
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
    
    private func endGame(reason: String, image: String, victory: Bool) {
            isGameOver = true
            gameOverReason = reason
            gameOverImage = image
            isVictory = victory
        }
    
    private func calculateFinalScore() {
        let averageStarvation = totalStarvationPercentage / Double(maxYears)
        let acresPerPerson = population > 0 ? (acres / population) : 0
        
        // Game Over (lose as Nero and Ivan IV)
        if averageStarvation > 0.33 || acresPerPerson < 7 {
            endGame(
                reason: "Your heavy-handed performance smacks of Nero and Ivan IV. The people (remaining) find you an unpleasant ruler, and, frankly, hate your guts!",
                image: "image_nero",
                victory: false
            )
        // Game Over (win as Trivial Problems)
        } else if averageStarvation > 0.03 || acresPerPerson < 10 {
            let assassins = Int.random(in: 1...15)
            endGame(
                reason: "Your performance could have been somewhat better, but really wasn't too bad at all. \(assassins) people would dearly like to see you assassinated, but we all have our trivial problems.",
                image: "image_trivial",
                victory: true
            )
        // Game Over (win as Charlemagne)
        } else {
            endGame(
                reason: "A fantastic performance! Charlemagne, Disraeli, and Jefferson combined could not have done better!",
                image: "image_charlemagne",
                victory: true
            )
        }
    }
    
    // MARK: Achievements logic and toast notifications queue
    var currentToast: Achievement? = nil
    private var toastQueue: [Achievement] = []
    
    func evaluateAchievements(lockedAchievements: [Achievement], totalGamesPlayed: Int) -> [Achievement] {
        var newlyUnlocked: [Achievement] = []
        
        for achievement in lockedAchievements {
            var didUnlock = false
            
            switch achievement.id {
            case "tragic_end": didUnlock = !isVictory
            case "victorious_reign": didUnlock = isVictory
            case "decade_power": didUnlock = (year > maxYears)
            case "national_fink": didUnlock = gameOverReason.lowercased().contains("fink")
            case "neros_shadow": didUnlock = gameOverReason.lowercased().contains("nero")
            case "trivial_pursuits": didUnlock = gameOverReason.lowercased().contains("trivial")
            case "charlemagne": didUnlock = gameOverReason.lowercased().contains("charlemagne")
            case "seasoned_ruler": didUnlock = (totalGamesPlayed >= 10)
            case "survivor": didUnlock = survivedPlagueThisGame
            case "bountiful_harvest": didUnlock = (maxHarvestThisGame >= 5)
            default: break
            }
            
            if didUnlock {
                newlyUnlocked.append(achievement)
            }
        }
        return newlyUnlocked
    }
    
    func displayToasts(for achievements: [Achievement]) {
        toastQueue.append(contentsOf: achievements)
        if currentToast == nil {
            showNextToast()
        }
    }
    
    private func showNextToast() {
        guard !toastQueue.isEmpty else {
            currentToast = nil
            return
        }
        
        currentToast = toastQueue.removeFirst()
        
        // Dismiss the toast
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.dismissToast()
        }
    }
    
    private func dismissToast() {
        currentToast = nil
        // Wait for the slideup animation to finish and then show the next one
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.showNextToast()
        }
    }
}
