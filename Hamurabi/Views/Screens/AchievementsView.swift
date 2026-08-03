import SwiftUI
import SwiftData

struct AchievementsView: View {
    // Fetch achievements from the database
    @Query(sort: \Achievement.title) private var allAchievements: [Achievement]
    
    // Computed properties to filter the lists
    var unlockedAchievements: [Achievement] {
        allAchievements.filter { $0.isUnlocked }
    }
    
    var lockedAchievements: [Achievement] {
        allAchievements.filter { !$0.isUnlocked }
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                
                // The Progress Bar
                VStack(spacing: 8) {
                    // Prevent division by 0 if database is somehow empty
                    let total = max(1, allAchievements.count)
                    
                    ProgressView(value: Double(unlockedAchievements.count), total: Double(total))
                        .progressViewStyle(.linear)
                        .tint(.orange)
                        .scaleEffect(x: 1, y: 2, anchor: .center)
                        .padding(.horizontal)
                    
                    Text("\(unlockedAchievements.count) / \(allAchievements.count) Achievements Unlocked")
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .foregroundColor(.secondary)
                }
                .padding(.top, 20)
                
                // Unlocked achievements section
                if !unlockedAchievements.isEmpty {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Unlocked Achievements")
                            .font(.title3)
                            .fontWeight(.black)
                            .padding(.horizontal)
                        
                        ForEach(unlockedAchievements) { achievement in
                            AchievementRow(achievement: achievement)
                                .padding(.horizontal)
                        }
                    }
                }
                
                // Locked achievements section
                if !lockedAchievements.isEmpty {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Locked Achievements")
                            .font(.title3)
                            .fontWeight(.black)
                            .foregroundColor(.secondary)
                            .padding(.horizontal)
                        
                        ForEach(lockedAchievements) { achievement in
                            AchievementRow(achievement: achievement)
                                .padding(.horizontal)
                        }
                    }
                }
            }
            .padding(.bottom, 30)
        }
        .navigationTitle("Achievements")
        .navigationBarTitleDisplayMode(.inline)
        .background(Color(UIColor.systemGroupedBackground))
    }
}

#Preview {
    NavigationStack {
        AchievementsView()
    }
}
