import SwiftUI

struct GameOverView: View {
    let viewModel: GameViewModel
    var onContinue: () -> Void
    
    var body: some View {
        VStack(spacing: 24) {
            Image(viewModel.gameOverImage)
                .resizable()
                .scaledToFit()
                .frame(height: 220)
                .background(Color(UIColor.systemGray5))
                .cornerRadius(12)
                .padding(.top, 40)
                .accessibilityHidden(true) // VoiceOver (screen reader) doesn't need to write the name of the images.
            
            VStack(alignment: .leading, spacing: 16) {
                Text(viewModel.gameOverReason)
                    .font(.headline)
                    .multilineTextAlignment(.leading)
                
                Text("SO LONG FOR NOW.")
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundColor(.secondary)
                    .tracking(2)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color(UIColor.secondarySystemBackground))
            .cornerRadius(12)
                
            Spacer()
            
            HamurabiButton(title: "Continue to Scoreboard", color: .orange) {
                onContinue()
            }
            .padding(.bottom, 20)
        }
        .padding(.horizontal)
    }
}

#Preview {
    let previewViewModel = GameViewModel()
    
    previewViewModel.gameOverReason = "You starved 45 people in one year! Due to this extreme mismanagement, you have not only been impeached and thrown out of office, but you have also been declared a national fink."
    previewViewModel.gameOverImage = "image_fink"
    previewViewModel.isVictory = false
    
    return GameOverView(viewModel: previewViewModel, onContinue: {})
}
