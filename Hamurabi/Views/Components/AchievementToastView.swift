import SwiftUI

struct AchievementToastView: View {
    var achievement: Achievement
    
    var body: some View {
        HStack(spacing: 12) {
            // Icon circle
            Image(systemName: achievement.systemImageName)
                .font(.title2)
                .foregroundColor(.white)
                .frame(width: 40, height: 40)
                .background(Circle().fill(Color.orange))
            
            // Text
            VStack(alignment: .leading, spacing: 2) {
                Text("Achievement Unlocked!")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(.white.opacity(0.8))
                    .textCase(.uppercase)
                
                Text(achievement.title)
                    .font(.headline)
                    .foregroundColor(.white)
            }
            
            Spacer()
        }
        .padding(14)
        .background(Color(UIColor.darkGray))
        .cornerRadius(30)
        .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
        .padding(.horizontal, 20)
        .padding(.top, 10) // Keeps it below the dynamic island
    }
}

#Preview {
    let dummy = Achievement(id: "test", title: "Victorious Reign", details: "", systemImageName: "crown.fill", colorName: "orange")
    VStack {
        AchievementToastView(achievement: dummy)
        Spacer()
    }
    .background(Color.black.opacity(0.1))
}
