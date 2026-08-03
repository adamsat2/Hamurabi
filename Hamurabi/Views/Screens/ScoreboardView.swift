import SwiftUI
import SwiftData

struct ScoreboardView: View {
    @Environment(\.dismiss) private var dismiss
    
    // Sort by years survived and then by population (as the less starvation, the better the type of game over), both descriptors are in descending order.
    @Query(sort: [
        SortDescriptor(\GameRecord.yearsSurvived, order: .reverse),
        SortDescriptor(\GameRecord.finalPopulation, order: .reverse)
    ]) private var allRecords: [GameRecord]
    
    var isFromGameOver: Bool = false
    var highlightedID: UUID? = nil
    var onReturnHome: (() -> Void)? = nil
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Hall of Kings")
                .font(.largeTitle)
                .fontWeight(.black)
                .foregroundColor(.orange)
                .padding(.top)
            
            if allRecords.isEmpty {
                Spacer()
                Text("No rulers have left a legacy yet.")
                    .font(.headline)
                    .foregroundColor(.secondary)
                Text("Play a game to enter the history books!")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Spacer()
            } else {
                // Header
                HStack {
                    Text("Rank").bold().frame(width: 50, alignment: .leading)
                    Text("Years").bold().frame(width: 50, alignment: .center)
                    Text("Pop").bold().frame(maxWidth: .infinity, alignment: .center)
                    Text("Acres").bold().frame(maxWidth: .infinity, alignment: .trailing)
                }
                .padding(.horizontal, 24)
                .font(.caption)
                .foregroundColor(.secondary)
                .textCase(.uppercase)
                
                ScrollView {
                    VStack(spacing: 12) {
                        // Only show top 10 records
                        let topRecords = Array(allRecords.prefix(10))
                        
                        ForEach(Array(topRecords.enumerated()), id: \.element.id) { index, record in
                            let isHighlighted = record.id == highlightedID
                            
                            HStack {
                                Text("#\(index + 1)")
                                    .font(.headline)
                                    .frame(width: 50, alignment: .leading)
                                
                                Text("\(record.yearsSurvived)")
                                    .frame(width: 50, alignment: .center)
                                
                                Text("\(record.finalPopulation)")
                                    .frame(maxWidth: .infinity, alignment: .center)
                                
                                Text("\(record.finalAcres)")
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                            }
                            .padding()
                            .background(isHighlighted ? Color.orange.opacity(0.3) : Color(UIColor.secondarySystemBackground))
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(isHighlighted ? Color.orange : Color.clear, lineWidth: 2)
                            )
                        }
                    }
                    .padding(.horizontal)
                }
            }
            
            // Only show this button if the player came directly from finishing a game
            if isFromGameOver {
                HamurabiButton(title: "Return to Main Menu") {
                    onReturnHome?()
                }
                .padding()
            }
        }
        // Hide the standard back arrow if the player came from finishing a game
        .navigationBarBackButtonHidden(isFromGameOver)
    }
}

#Preview {
    ScoreboardView()
}
