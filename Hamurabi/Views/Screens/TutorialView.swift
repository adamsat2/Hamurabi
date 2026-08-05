import SwiftUI

// Struct to hold page data
struct TutorialPage: Identifiable {
    let id: Int
    let title: String
    let description: String
    let imageName: String
    let warningText: String?
}

struct TutorialView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var currentPage = 0
    
    let pages: [TutorialPage] = [
        TutorialPage(id: 0, title: "The Goal", description: "You have 10 years to rule Ancient Babylon. Your mission is simple: keep your people alive, manage your land, and don't get impeached by an angry mob.", imageName: "image_report", warningText: nil),
        
        TutorialPage(id: 1, title: "The Economy", description: "Land is your most valuable asset. The price of land fluctuates wildly every year. Buy low when land is cheap, and sell high to build up your grain reserves.", imageName: "image_land", warningText: nil),
        
        TutorialPage(id: 2, title: "Feeding the City", description: "Your people need food to survive. It takes exactly 20 bushels of grain to feed one person for a year.", imageName: "image_feed", warningText: "WARNING: If you starve more than 45% of your population in a single year, you will be instantly impeached!"),
        
        TutorialPage(id: 3, title: "The Harvest", description: "Every year you must plant seeds for the future. You need 1 bushel of seed per acre of land. Harvests are unpredictable - you might yield anywhere from 1 to 5 bushels per acre.", imageName: "image_plant", warningText: nil),
        
        TutorialPage(id: 4, title: "The Dangers", description: "Nature is unforgiving. Watch out for rat infestations that can eat massive portions of your grain, and the dreaded plague that can wipe out half your city in an instant. Good luck!", imageName: "image_fink", warningText: nil)
    ]
    
    var body: some View {
        VStack {
            // The swipeable view
            TabView(selection: $currentPage) {
                ForEach(pages) { page in
                    VStack(spacing: 24) {
                        Text(page.title)
                            .font(.largeTitle)
                            .fontWeight(.black)
                            .foregroundColor(.orange)
                            .padding(.top, 20)
                        
                        Image(page.imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                            .background(Color(UIColor.systemGray5))
                            .cornerRadius(12)
                        
                        VStack(spacing: 16) {
                            Text(page.description)
                                .font(.body)
                                .multilineTextAlignment(.center)
                            
                            if let warning = page.warningText {
                                Text(warning)
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                                    .foregroundColor(.red)
                                    .multilineTextAlignment(.center)
                                    .padding()
                                    .background(Color.red.opacity(0.1))
                                    .cornerRadius(8)
                            }
                        }
                        .padding()
                        .background(Color(UIColor.secondarySystemBackground))
                        .cornerRadius(12)
                        
                        Spacer()
                    }
                    .padding(.horizontal)
                    .tag(page.id) // Bind between tab and page from the pages list
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .always))
            .indexViewStyle(.page(backgroundDisplayMode: .always)) // Makes the dots visible on any background
            
            // Navigation buttons
            HStack(spacing: 16) {
                // Back button (hidden on the first page)
                if currentPage > 0 {
                    Button(action: {
                        withAnimation { currentPage -= 1 }
                    }) {
                        Image(systemName: "chevron.left.circle.fill")
                            .font(.system(size: 44))
                            .foregroundColor(.gray)
                    }
                }
                
                // Main button
                if currentPage == pages.count - 1 {
                    HamurabiButton(title: "Finish Tutorial", color: .orange) {
                        dismiss()
                    }
                } else {
                    HamurabiButton(title: "Next", color: .orange) {
                        withAnimation { currentPage += 1 }
                    }
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 20)
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    TutorialView()
}
