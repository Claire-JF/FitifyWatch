import SwiftUI

struct GenrePickerView: View {
    let workout: String
    let genres = ["Rock", "Indie", "Pop", "Metal", "Alt", "Country", "Dance", "Folk", "Jazz", "Latin", "Lo-fi", "Punk"]
    @State private var selectedGenres: Set<String> = []
    @State private var navigateToWorkoutStart = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 15) {
                Text("Select Music Genres")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.customBlack)
                
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                    ForEach(genres, id: \.self) { genre in
                        GenreButton(genre: genre, isSelected: selectedGenres.contains(genre)) {
                            if selectedGenres.contains(genre) {
                                selectedGenres.remove(genre)
                            } else {
                                selectedGenres.insert(genre)
                            }
                        }
                    }
                }
                .padding(.horizontal, 5)
                
                NavigationLink(destination: WorkoutStartView(workout: workout, selectedGenres: selectedGenres), isActive: $navigateToWorkoutStart) {
                    Button(action: {
                        navigateToWorkoutStart = true
                    }) {
                        Text("Continue")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.customBackground)
                            .frame(width: 100, height: 36)
                            .background(Color.customRed)
                            .cornerRadius(18)
                    }
                }
                .disabled(selectedGenres.isEmpty)
                .opacity(selectedGenres.isEmpty ? 0.5 : 1)
                .padding(.top, 10)
            }
            .padding(.top, 10)
        }
        .background(Color.customBackground.edgesIgnoringSafeArea(.all))
    }
}

struct GenreButton: View {
    let genre: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(genre)
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(isSelected ? .customBackground : .customBlack)
                .frame(height: 32)
                .frame(maxWidth: .infinity)
                .background(isSelected ? Color.customOrange : Color.customBackground)
                .cornerRadius(16)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.customDarkOrange, lineWidth: isSelected ? 0 : 1)
                )
        }
    }
}

#Preview {
    GenrePickerView(workout: "Running")
}
