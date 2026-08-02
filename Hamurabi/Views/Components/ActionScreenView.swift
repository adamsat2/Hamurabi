import SwiftUI

struct ActionScreenView: View {
    var text: String
    var imageName: String
    var maxAmount: Int
    var inputTitle: String
    
    @State private var inputAmount: Int? = nil
    // This closure sends the data back to GameView when the button is pressed
    var onSubmit: (_ amount: Int) -> Void
    
    var body: some View {
        VStack(spacing: 24) {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 200)
                .background(Color(UIColor.systemGray5))
                .cornerRadius(12)
            
            Text(text)
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            ResourceInputView(
                title: inputTitle,
                amount: $inputAmount,
                maxAmount: maxAmount
            )
            .padding(.horizontal)
            
            Spacer()
            
            HamurabiButton(title: "Confirm") {
                let finalAmount = inputAmount ?? 0
                onSubmit(finalAmount)
                inputAmount = nil
            }
            .padding(.horizontal)
        }
        .onChange(of: inputAmount) { oldValue, newValue in
            if let new = newValue, new > maxAmount {
                inputAmount = maxAmount
            }
        }
    }
}
