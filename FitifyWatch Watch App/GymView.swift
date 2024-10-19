import SwiftUI

struct GymView: View {
    let workouts = [
        "Running", "Lifting", "Biking", "Swimming",
        "Yoga", "HIIT", "Pilates", "Boxing",
        "Rowing", "Elliptical", "Stair Climber", "Jump Rope"
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                Text("Select your workout")
                    .font(.system(size: 13))
                    .foregroundColor(.customBlack)
                
                VStack(alignment: .leading, spacing: 10) {
                    ForEach(workouts, id: \.self) { workout in
                        NavigationLink(destination: GenrePickerView(workout: workout)) {
                            Text(workout)
                                .font(.system(size: 13))
                                .foregroundColor(.customBackground)
                                .frame(maxWidth: .infinity)
                                .padding(EdgeInsets(top: 13, leading: 26, bottom: 13, trailing: 26))
                                .background(Color.customOrange)
                                .cornerRadius(15)
                        }
                    }
                }
                .frame(width: 152)
            }
            .padding(EdgeInsets(top: 5, leading: 17, bottom: 0, trailing: 17))
            .frame(maxWidth: .infinity)
            .background(Color.customBackground)
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.customDarkOrange, lineWidth: 0.5)
            )
        }
    }
}

#Preview {
    GymView()
}
