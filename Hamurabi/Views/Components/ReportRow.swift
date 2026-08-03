import SwiftUI

struct ReportRow: View {
    var icon: String
    var text: String
    var color: Color = .primary
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(color == .primary ? .orange : color)
                .frame(width: 24)
            Text(text)
                .foregroundColor(color)
                .font(.subheadline)
                .fontWeight(color == .primary ? .regular : .semibold)
        }
    }
}

#Preview {
    VStack(alignment: .leading, spacing: 10) {
        ReportRow(icon: "person.crop.circle.badge.minus", text: "12 people starved")
        ReportRow(icon: "person.fill.xmark", text: "The plague took the lives of 50 people", color: .red)
    }
    .padding()
}
