import SwiftUI

struct TransitionView: View {
    var onContinue: () -> Void
    
    var body: some View {
        VStack(spacing: 32) {
            Spacer()
            
            Image("image_transition")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, alignment: .center)
                .background(Color(UIColor.systemGray5))
                .cornerRadius(12)
                .padding(.horizontal)
                .accessibilityHidden(true)
            
            Text("Wisdom or folly?\nTime shall tell...")
                .font(.title2)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)
                .padding(.horizontal)
            
            Spacer()
            
            HamurabiButton(title: "See Results", color: .orange) {
                onContinue()
            }
            .padding(.horizontal)
            .padding(.bottom, 20)
        }
        .padding(.top)
        .transition(.opacity)
    }
}

#Preview {
    TransitionView(onContinue: {})
}
