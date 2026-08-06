import SwiftUI

struct AchievementRow: View {
    var achievement: Achievement
    
    // Helper to turn string color name into an actual SwiftUI Color
    var iconColor: Color {
        switch achievement.colorName {
        case "red": return .red
        case "orange": return .orange
        case "blue": return .blue
        case "purple": return .purple
        case "gray": return .gray
        case "brown": return .brown
        case "green": return .green
        case "mint": return .mint
        default: return .accentColor
        }
    }
    
    var body: some View {
        HStack(spacing: 16) {
            // The icon box
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(achievement.isUnlocked ? iconColor.opacity(0.2) : Color.gray.opacity(0.2))
                    .frame(width: 60, height: 60)
                
                Image(systemName: achievement.systemImageName)
                    .font(.title2)
                    .foregroundColor(achievement.isUnlocked ? iconColor : .gray)
                    .opacity(achievement.isUnlocked ? 1.0 : 0.3)
                
                // The lock overlay (for locked achievements)
                if !achievement.isUnlocked {
                    Image(systemName: "lock.fill")
                        .font(.title3)
                        .foregroundColor(.secondary)
                }
            }
            
            // The text
            VStack(alignment: .leading, spacing: 4) {
                Text(achievement.title)
                    .font(.headline)
                    .foregroundColor(achievement.isUnlocked ? .primary : .secondary)
                
                Text(achievement.details)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .fixedSize(horizontal: false, vertical: true) // To handle long description properly rather than cutting them off
            }
            
            Spacer()
        }
        .padding()
        .background(Color(UIColor.secondarySystemGroupedBackground))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
}

#Preview("Locked Example") {
    let unlockedDummyAchievement = Achievement(id: "test", title: "The New Charlemagne", details: "Achieve a perfect 10-year score.", systemImageName: "building.columns.fill", colorName: "mint", isUnlocked: true)
    let lockedDummyAchievement = Achievement(id: "test2", title: "A Decade of Power", details: "Survive all 10 years of your rule.", systemImageName: "hourglass.bottomhalf.filled", colorName: "blue", isUnlocked: false)
    
    return Group(){
        AchievementRow(achievement: unlockedDummyAchievement)
        AchievementRow(achievement: lockedDummyAchievement)
    }
        .background(Color(UIColor.systemGroupedBackground))
}
