import SwiftUI

struct ActionScreenView: View {
    var text: String
    var imageName: String
    var maxAmount: Int
    var inputTitle: String
    var onSubmit: (_ amount: Int) -> Void // This closure sends the data back to GameView when the button is pressed
    
    @State private var inputText: String = ""
    @FocusState private var isFocused: Bool
    
    var body: some View {
        VStack(spacing: 24) {
            Text(text)
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 200)
                .background(Color(UIColor.systemGray5))
                .cornerRadius(12)
                .padding(.horizontal)
                .accessibilityHidden(true) // VoiceOver (screen reader) doesn't need to write the name of the images.
            
            Text("Max available: \(maxAmount)")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            TextField(inputTitle, text: $inputText)
                .keyboardType(.numberPad) // Forces the number keyboard
                .focused($isFocused)
                .textFieldStyle(.roundedBorder)
                .multilineTextAlignment(.center)
                .font(.title2)
                .padding(.horizontal, 40)
            
            Spacer()
            
            HamurabiButton(title: "Confirm Edict", color: .orange) {
                isFocused = false
                let parsedAmount = Int(inputText) ?? 0 // Type check input
                let safeAmount = min(max(parsedAmount, 0), maxAmount) // Number limit check [0, maxAmount]
                
                onSubmit(safeAmount)
                inputText = ""
            }
            .padding(.horizontal)
            .padding(.bottom, 20)
        }
        .padding(.top)
        .onAppear {
            isFocused = true // Enter the keyboard when appearing to avoid needless tap
        }
    }
}

#Preview {
    ActionScreenView(
        text: "How much land do you want to buy?",
        imageName: "image_land",
        maxAmount: 50,
        inputTitle: "Acres to Buy",
        onSubmit: { _ in }
    )
}
