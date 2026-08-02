import SwiftUI

struct MainView: View {
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
                    
                    NavigationLink(destination: Text("Scoreboard Coming Soon")) {
                        HamurabiButton(title: "Scoreboard", color: .secondary, action: {})
                            .disabled(true)
                    }
                    
                    NavigationLink(destination: Text("Achievements Coming Soon")) {
                        HamurabiButton(title: "Achievements", color: .secondary, action: {})
                            .disabled(true)
                    }
                }
                .padding(.horizontal, 40)
                
                Spacer()
            }
            .background(Color(UIColor.systemBackground))
        }
    }
}

#Preview {
    MainView()
}
