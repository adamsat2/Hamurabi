import SwiftUI

enum GameStep {
    case report
    case buyLand
    case sellLand
    case feed
    case plant
}

struct GameView: View {
    @State private var viewModel = GameViewModel()
    @State private var currentStep: GameStep = .report
    
    var body: some View {
        VStack {
            // MARK: Header status bar
            if currentStep != .report {
                HStack {
                    ResourceCardView(title: "Pop", value: viewModel.population, systemImage: "person.3.fill")
                    ResourceCardView(title: "Bushels", value: viewModel.bushels, systemImage: "leaf.fill")
                    ResourceCardView(title: "Acres", value: viewModel.acres, systemImage: "square.grid.3x3.fill")
                }
                .padding(.horizontal)
                .padding(.bottom, 10)
                // Adds an effect when it appears
                .transition(.move(edge: .top).combined(with: .opacity))
            }
            
            // MARK: Screen loop
            Group {
                switch currentStep {
                case .report:
                    royalReportScreen
                        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                        
                case .buyLand:
                    ActionScreenView(
                        text: "Hamurabi, we must manage our territory. Land is trading at \(viewModel.landPrice) bushels per acre.",
                        imageName: "image_land",
                        maxAmount: viewModel.bushels / viewModel.landPrice,
                        inputTitle: "Acres to Buy",
                        onSubmit: { amount in
                            if amount == 0 {
                                advanceStep(to: .sellLand)
                            } else {
                                viewModel.processLandTransaction(amount: amount, isBuying: true)
                                advanceStep(to: .feed)
                            }
                        }
                    )
                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                    
                case .sellLand:
                    ActionScreenView(
                        text: "Since you bought no land, do you wish to sell any? Land is trading at \(viewModel.landPrice) bushels per acre.",
                        imageName: "image_land",
                        maxAmount: viewModel.acres,
                        inputTitle: "Acres to SELL",
                        onSubmit: { amount in
                            viewModel.processLandTransaction(amount: amount, isBuying: false)
                            advanceStep(to: .feed)
                        }
                    )
                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                    
                case .feed:
                    ActionScreenView(
                        text: "The people look to you for sustenance. We have \(viewModel.population) citizens to feed. It takes \(viewModel.bushelsToFeedOnePerson) bushels to feed one person.",
                        imageName: "image_feed",
                        maxAmount: viewModel.bushels,
                        inputTitle: "Bushels to allocate",
                        onSubmit: { amount in
                            viewModel.feedPeople(amount: amount)
                            if viewModel.isGameOver {
                                print("Game Over: Starvation!")
                            } else {
                                advanceStep(to: .plant)
                            }
                        }
                    )
                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                    
                case .plant:
                    ActionScreenView(
                        text: "We must sow seeds for the future. You can plant up to \(viewModel.population * 10) acres, assuming we have the land and seed.",
                        imageName: "image_plant",
                        maxAmount: min(viewModel.acres, viewModel.population * 10, viewModel.bushels),
                        inputTitle: "Acres to plant",
                        onSubmit: { amount in
                            viewModel.plantSeedsAndEndYear(amount: amount)
                            if viewModel.isGameOver {
                                print("Game Over: Time Limit")
                            } else {
                                advanceStep(to: .report)
                            }
                        }
                    )
                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                }
            }
        }
        .navigationTitle("Year \(viewModel.year)")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
    }
    
    // MARK: - Screens and navigation
    private var royalReportScreen: some View {
        VStack(spacing: 16) {
            Text("Hamurabi: I beg to report to you...")
                .font(.headline).italic().foregroundColor(.orange)
                .frame(maxWidth: .infinity, alignment: .leading)
                
            Image("image_report")
                .resizable()
                .scaledToFit()
                .frame(height: 200)
                .background(Color(UIColor.systemGray5))
                .cornerRadius(12)
            
            VStack(alignment: .leading, spacing: 10) {
                ReportRow(icon: "person.crop.circle.badge.minus", text: "\(viewModel.starved) people starved")
                
                if viewModel.plagueDeaths > 0 {
                    ReportRow(icon: "skull.fill", text: "The plague took the lives of \(viewModel.plagueDeaths) people", color: .red)
                }
                
                ReportRow(icon: "person.crop.circle.badge.plus", text: "\(viewModel.newcomers) people came to the city")
                ReportRow(icon: "person.3.fill", text: "The population is now \(viewModel.population)")
                ReportRow(icon: "square.grid.3x3.fill", text: "The city now owns \(viewModel.acres) acres")
                ReportRow(icon: "leaf.arrow.triangle.circlepath", text: "You harvested \(viewModel.harvestPerAcre) bushels per acre")
                
                if viewModel.ratsAte > 0 {
                    ReportRow(icon: "pawprint.fill", text: "Rats ate \(viewModel.ratsAte) bushels", color: .red)
                }
                
                ReportRow(icon: "leaf.fill", text: "You now have \(viewModel.bushels) bushels in store")
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color(UIColor.secondarySystemBackground))
            .cornerRadius(12)
            
            Spacer()
            
            HamurabiButton(title: "Issue Edicts") {
                advanceStep(to: .buyLand)
            }
        }
        .padding(.horizontal)
    }
    
    private func advanceStep(to next: GameStep) {
        withAnimation(.easeInOut(duration: 0.4)) {
            currentStep = next
        }
    }
}

// A small reusable component specifically for the report list
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
    NavigationStack {
        GameView()
    }
}
