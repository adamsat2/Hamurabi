import SwiftUI
import SwiftData

enum AppRoute: Hashable {
    case game
    case tutorial
    case scoreboard
    case achievements
}

struct MainView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var achievements: [Achievement]
    
    @State private var navPath = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $navPath) {
            VStack(spacing: 40) {
                // Title
                VStack {
                    Text("HAMURABI")
                        .font(.system(size: 48, weight: .black, design: .serif))
                        .foregroundColor(.orange)
                        .tracking(5)
                    
                    Text("Ruler of Ancient Babylon")
                        .font(.headline)
                        .foregroundColor(.secondary)
                }
                .padding(.top, 60)
                
                Spacer()
                Spacer()
                
                // Navigation Buttons
                VStack(spacing: 20) {
                    HamurabiButton(title: "Play", color: .orange) {
                        navPath.append(AppRoute.game)
                    }
                    
                    HamurabiButton(title: "How to Play", color: .orange) {
                        navPath.append(AppRoute.tutorial)
                    }
                    
                    HamurabiButton(title: "Scoreboard", color: .orange) {
                        navPath.append(AppRoute.scoreboard)
                    }
                    
                    HamurabiButton(title: "Achievements", color: .orange) {
                        navPath.append(AppRoute.achievements)
                    }
                }
                .padding(.horizontal, 40)
                
                VStack(spacing: 4) {
                    Text("Based on the original 1968 game by Doug Dyment")
                    Text("and the 1973 BASIC port by David Ahl")
                }
                .font(.caption)
                .fontWeight(.bold)
                .foregroundColor(.secondary)
                .padding(.top, 10)
                .padding(.bottom, 20)
                
                Spacer()
                
            }
            .background(Color(UIColor.systemBackground))
            // Load the correct screen
            .navigationDestination(for: AppRoute.self) { route in
                switch route {
                case .game:
                    GameView()
                case .tutorial:
                    TutorialView()
                case .scoreboard:
                    ScoreboardView(isFromGameOver: false)
                case .achievements:
                    AchievementsView()
                }
            }
        }
        .onAppear {
            seedAchievementsIfEmpty()
        }
    }
    
    private func seedAchievementsIfEmpty() {
        if achievements.isEmpty {
            for defaultAchievement in Achievement.defaults {
                modelContext.insert(defaultAchievement)
            }
        }
    }
}

#Preview {
    MainView()
}
