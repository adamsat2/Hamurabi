import Foundation
import SwiftData

@Model
final class Achievement {
    @Attribute(.unique) var id: String
    var title: String
    var details: String
    var systemImageName: String // SF Symbols icon
    var isUnlocked: Bool
    var unlockedDate: Date?
    
    init(id: String, title: String, details: String, systemImageName: String, isUnlocked: Bool = false, unlockedDate: Date? = nil) {
        self.id = id
        self.title = title
        self.details = details
        self.systemImageName = systemImageName
        self.isUnlocked = isUnlocked
        self.unlockedDate = unlockedDate
    }
}
