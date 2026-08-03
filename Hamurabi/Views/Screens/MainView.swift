import SwiftUI
import SwiftData

struct MainView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var achievements: [Achievement]
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 40) {
                // Title
                VStack {
                    Text("HAMURABI")
                        .font(.system(size: 48, weight: .black, design: .serif))
                        .foregroundColor(.orange)
                        .tracking(5) // Some trick for aesthetics
                    
                    Text("Ruler of Ancient Babylon")
                        .font(.headline)
                        .foregroundColor(.secondary)
                }
                .padding(.top, 60)
                
                Spacer()
                
                // Navigation Buttons
                VStack(spacing: 20) {
                    NavigationLink(destination: GameView()) {
                        HamurabiButton(title: "Play", action: {})
                            .disabled(true) // Rely on NavigationLink's tap instead of the button's action
                    }
                    
                    NavigationLink(destination: Text("Tutorial Screen Coming Soon")) {
                        HamurabiButton(title: "How to Play", color: .secondary, action: {})
                            .disabled(true)
                    }
                    
                    NavigationLink(destination: ScoreboardView(isFromGameOver: false)) {
                            HamurabiButton(title: "Scoreboard", action: {})
                        }
                    
                    NavigationLink(destination: Text("Achievements Coming Soon")) {
                        HamurabiButton(title: "Achievements", color: .secondary, action: {})
                    }
                }
                .padding(.horizontal, 40)
                
                Spacer()
            }
            .background(Color(UIColor.systemBackground))
        }
        .onAppear {
            seedAchievementsIfEmpty()
        }
    }
    
    private func seedAchievementsIfEmpty() {
        if achievements.isEmpty {
            print("Database empty: Seeding initial achievements...")
            for defaultAchievement in Achievement.defaults {
                modelContext.insert(defaultAchievement)
            }
        } else {
            print("\(achievements.count) achievements found. Skipping seed.")
        }
    }
}

#Preview {
    MainView()
}
