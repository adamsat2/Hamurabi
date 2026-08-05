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
                .fixedSize(horizontal: false, vertical: true)
                .padding(.horizontal)
            
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(height: isFocused ? 0 : 200)
                .background(Color(UIColor.systemGray5))
                .cornerRadius(12)
                .opacity(isFocused ? 0 : 1)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.horizontal)
                .accessibilityHidden(true) // VoiceOver (screen reader) doesn't need to write the name of the images.
            
            Text("Max available: \(maxAmount)")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            TextField(inputTitle, text: $inputText)
                .keyboardType(.numberPad) // Opens the number keyboard
                .focused($isFocused)
                .textFieldStyle(.roundedBorder)
                .multilineTextAlignment(.center)
                .font(.title2)
                .padding(.horizontal, 40)
                .onChange(of: inputText) { _, newValue in
                    var filtered = newValue.filter { $0.isNumber }
                    while filtered.hasPrefix("0") && filtered.count > 1 {
                        filtered.removeFirst()
                    }
                    
                    if let intValue = Int(filtered), intValue > maxAmount {
                        filtered = String(maxAmount)
                    }
                    
                    if inputText != filtered {
                        inputText = filtered
                    }
                }
            
            Text("Leave blank for 0")
                .font(.caption)
                .foregroundColor(.secondary)
                .padding(.top, -16)
            
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
        // Can click on the empty space to dismiss the number keyboard
        .contentShape(Rectangle())
        .onTapGesture {
            isFocused = false
        }
        .animation(.easeInOut(duration: 0.3), value: isFocused)
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
