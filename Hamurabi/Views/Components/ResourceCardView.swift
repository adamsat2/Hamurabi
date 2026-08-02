import SwiftUI

struct ResourceCardView: View {
    var title: String
    var value: Int
    var systemImage: String
    
    var body: some View {
        VStack(spacing: 6) {
            Image(systemName: systemImage)
                .font(.title3)
                .foregroundColor(.orange)
            
            Text("\(value)")
                .font(.headline)
                .fontWeight(.bold)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
            
            Text(title)
                .font(.caption2)
                .foregroundColor(.secondary)
                .textCase(.uppercase)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
        .padding(.horizontal, 4)
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(12)
    }
}

#Preview {
    HStack {
        ResourceCardView(title: "Pop", value: 100, systemImage: "person.3.fill")
        ResourceCardView(title: "Bushels", value: 2800, systemImage: "leaf.fill")
        ResourceCardView(title: "Acres", value: 1000, systemImage: "square.grid.3x3.fill")
    }
    .padding()
}
