import SwiftUI

struct HamurabiButton: View {
    var title: String
    var color: Color = .accentColor
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.headline)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity)
                .padding()
                .background(color)
                .foregroundColor(.white)
                .cornerRadius(12)
                .shadow(color: color.opacity(0.3), radius: 5, x: 0, y: 3)
        }
    }
}

#Preview {
    VStack {
        HamurabiButton(title: "Play Game", action: {})
        HamurabiButton(title: "Sell Land", color: .red, action: {})
    }
    .padding()
}
