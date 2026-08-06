import Foundation
import SwiftData

@Model
final class Achievement {
    @Attribute(.unique) var id: String
    var title: String
    var details: String
    var systemImageName: String // SF icon
    var colorName: String
    var isUnlocked: Bool
    var unlockedDate: Date?
    
    init(id: String, title: String, details: String, systemImageName: String, colorName: String, isUnlocked: Bool = false, unlockedDate: Date? = nil) {
        self.id = id
        self.title = title
        self.details = details
        self.systemImageName = systemImageName
        self.colorName = colorName
        self.isUnlocked = isUnlocked
        self.unlockedDate = unlockedDate
    }
}

// MARK: Achievements
extension Achievement {
    static let defaults: [Achievement] = [
        Achievement(id: "tragic_end", title: "A Tragic End", details: "Lose any game.", systemImageName: "xmark.shield.fill", colorName: "red"),
        Achievement(id: "victorious_reign", title: "Victorious Reign", details: "Win any game.", systemImageName: "crown.fill", colorName: "orange"),
        Achievement(id: "decade_power", title: "A Decade of Power", details: "Survive all 10 years of your rule.", systemImageName: "hourglass.bottomhalf.filled", colorName: "blue"),
        Achievement(id: "national_fink", title: "The National Fink", details: "Starve over 45% of your population in a single year.", systemImageName: "person.crop.circle.badge.xmark", colorName: "red"),
        Achievement(id: "neros_shadow", title: "Nero's Shadow", details: "Survive 10 years, but be hated by your remaining people.", systemImageName: "figure.mind.and.body", colorName: "purple"),
        Achievement(id: "trivial_pursuits", title: "Trivial Pursuits", details: "Survive 10 years with a mediocre score.", systemImageName: "questionmark.circle.fill", colorName: "mint"),
        Achievement(id: "charlemagne", title: "The New Charlemagne", details: "Achieve a perfect 10-year score.", systemImageName: "building.columns.fill", colorName: "orange"),
        Achievement(id: "seasoned_ruler", title: "Seasoned Ruler", details: "Complete 10 total games of Hamurabi.", systemImageName: "scroll.fill", colorName: "brown"),
        Achievement(id: "survivor", title: "Survivor", details: "Survive a plague without a Game Over in the same year.", systemImageName: "shield.lefthalf.filled", colorName: "green"),
        Achievement(id: "bountiful_harvest", title: "Bountiful Harvest", details: "Harvest the maximum of 5 bushels per acre.", systemImageName: "leaf.fill", colorName: "green")
    ]
}
