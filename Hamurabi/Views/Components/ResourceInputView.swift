import SwiftUI

struct ResourceInputView: View {
    var title: String
    @Binding var amount: Int?
    var maxAmount: Int
    
    // Tracks whether keyboard is active/focused
    @FocusState private var isInputActive: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.subheadline)
                .fontWeight(.medium)
            
            HStack {
                TextField("0", value: $amount, format: .number)
                    .keyboardType(.numberPad)
                    .focused($isInputActive)
                    .padding()
                    .background(Color(UIColor.tertiarySystemBackground))
                    .cornerRadius(8)
                    // Add a 'Done' button
                    .toolbar {
                        ToolbarItemGroup(placement: .keyboard) {
                            Spacer() // Push the button to the right side
                            Button("Done") {
                                isInputActive = false // Hide the keyboard
                            }
                        }
                    }
                
                Button(action: {
                    // Hide the keyboard since we got an input from MAX
                    isInputActive = false
                    amount = maxAmount
                }) {
                    Text("MAX")
                        .font(.caption)
                        .fontWeight(.bold)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 16)
                        .background(Color.orange.opacity(0.2))
                        .foregroundColor(.orange)
                        .cornerRadius(8)
                }
            }
            
            Text("Available: \(maxAmount)")
                .font(.caption2)
                .foregroundColor(.secondary)
        }
    }
}

#Preview {
    @Previewable @State var testAmount: Int? = nil
    ResourceInputView(title: "Acres to Buy", amount: $testAmount, maxAmount: 1000)
        .padding()
}
