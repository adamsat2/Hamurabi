import Foundation
import SwiftData

@Model
final class GameRecord {
    var datePlayed: Date
    var yearsSurvived: Int
    var finalPopulation: Int
    var finalAcres: Int
    var finalBushels: Int
    var performanceRating: String
    
    init(datePlayed: Date = .now, yearsSurvived: Int = 0, finalPopulation: Int = 0, finalAcres: Int = 0, finalBushels: Int = 0, performanceRating: String = "") {
        self.datePlayed = datePlayed
        self.yearsSurvived = yearsSurvived
        self.finalPopulation = finalPopulation
        self.finalAcres = finalAcres
        self.finalBushels = finalBushels
        self.performanceRating = performanceRating
    }
}
