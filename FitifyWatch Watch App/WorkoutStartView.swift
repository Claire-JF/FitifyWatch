import SwiftUI

struct WorkoutStartView: View {
    let workout: String
    let selectedGenres: Set<String>
    @State private var countdown = 3
    @State private var isCountingDown = false
    @State private var workoutStarted = false
    @State private var bpm: Int = 0
    @State private var pace: Double = 0.0
    @State private var isPaused = false
    @State private var recommendedSong: String? = nil
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.customBackground.edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 10) {
                    Text(workoutStarted ? workout : "Get Ready for \(workout)")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.customBlack)
                        .multilineTextAlignment(.center)
                    
                    if isCountingDown {
                        Text("\(countdown)")
                            .font(.system(size: 50, weight: .bold))
                            .foregroundColor(.customRed)
                            .transition(.scale)
                    } else if workoutStarted {
                        workoutInfoView
                    } else {
                        Image(systemName: "figure.run")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: geometry.size.height * 0.25)
                            .foregroundColor(.customOrange)
                    }
                    
                    if let song = recommendedSong {
                        Text("Now Playing: \(song)")
                            .font(.system(size: 12))
                            .foregroundColor(.customDarkOrange)
                            .lineLimit(1)
                            .truncationMode(.tail)
                    } else {
                        Text("Music: \(selectedGenres.joined(separator: ", "))")
                            .font(.system(size: 12))
                            .foregroundColor(.customBlack)
                            .lineLimit(1)
                            .truncationMode(.tail)
                    }
                    
                    if !isCountingDown && !workoutStarted {
                        Button(action: startCountdown) {
                            Text("Start Workout")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.customBackground)
                                .frame(maxWidth: .infinity)
                                .frame(height: 40)
                                .background(Color.customRed)
                                .cornerRadius(20)
                        }
                        .padding(.horizontal)
                    } else if workoutStarted {
                        HStack(spacing: 15) {
                            IconButton(iconName: isPaused ? "play.fill" : "pause.fill", action: togglePause)
                            MusicRecommendButton(action: recommendMusic)
                            IconButton(iconName: "stop.fill", action: stopWorkout)
                        }
                    }
                }
                .padding(.vertical, 5)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
    }
    
    var workoutInfoView: some View {
        HStack(spacing: 10) {
            VStack {
                Text("BPM")
                    .font(.system(size: 12))
                    .foregroundColor(.customBlack)
                Text("\(bpm)")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.customRed)
            }
            
            if recommendedSong != nil {
                RotatingMusicPlayerAnimation()
                    .frame(width: 50, height: 50)
            } else {
                WorkoutAnimation()
                    .frame(width: 50, height: 50)
            }
            
            VStack {
                Text("Pace")
                    .font(.system(size: 12))
                    .foregroundColor(.customBlack)
                Text(String(format: "%.1f", pace))
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.customRed)
            }
        }
        .transition(.opacity)
    }
    
    func startCountdown() {
        isCountingDown = true
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if countdown > 0 {
                countdown -= 1
            } else {
                timer.invalidate()
                withAnimation {
                    isCountingDown = false
                    workoutStarted = true
                }
                startWorkoutSimulation()
            }
        }
    }
    
    func startWorkoutSimulation() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if !isPaused {
                withAnimation {
                    bpm = Int.random(in: 120...180)
                    pace = Double.random(in: 4.0...8.0)
                }
            }
        }
    }
    
    func togglePause() {
        isPaused.toggle()
    }
    
    func recommendMusic() {
        // Simulate recommending a song
        let songs = ["Shape of You", "Blinding Lights", "Dance Monkey", "Uptown Funk", "Happy"]
        recommendedSong = songs.randomElement()
    }
    
    func stopWorkout() {
        // Implement stop workout logic here
        print("Stopping workout")
    }
}

struct WorkoutAnimation: View {
    @State private var isAnimating = false
    
    var body: some View {
        Image(systemName: "figure.run")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .foregroundColor(.customOrange)
            .rotationEffect(.degrees(isAnimating ? 360 : 0))
            .animation(Animation.linear(duration: 4).repeatForever(autoreverses: false), value: isAnimating)
            .onAppear {
                isAnimating = true
            }
    }
}

struct RotatingMusicPlayerAnimation: View {
    @State private var isRotating = false
    
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.customOrange)
                .frame(width: 50, height: 50)
            
            Image(systemName: "music.note")
                .font(.system(size: 20))
                .foregroundColor(.customBackground)
        }
        .rotationEffect(.degrees(isRotating ? 360 : 0))
        .animation(Animation.linear(duration: 2).repeatForever(autoreverses: false), value: isRotating)
        .onAppear {
            isRotating = true
        }
    }
}

struct IconButton: View {
    let iconName: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: iconName)
                .font(.system(size: 20))
                .foregroundColor(.customBackground)
                .frame(width: 40, height: 40)
                .background(Color.customDarkOrange)
                .clipShape(Circle())
        }
    }
}

struct MusicRecommendButton: View {
    let action: () -> Void
    @State private var isAnimating = false
    
    var body: some View {
        Button(action: {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.6, blendDuration: 0)) {
                isAnimating = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                isAnimating = false
            }
            action()
        }) {
            Image(systemName: "music.note")
                .font(.system(size: 20))
                .foregroundColor(.customBackground)
                .frame(width: 40, height: 40)
                .background(Color.customRed)
                .clipShape(Circle())
                .scaleEffect(isAnimating ? 1.2 : 1.0)
                .overlay(
                    Circle()
                        .stroke(Color.customOrange, lineWidth: 2)
                        .scaleEffect(isAnimating ? 1.4 : 1.0)
                        .opacity(isAnimating ? 0 : 1)
                )
                .animation(.easeInOut(duration: 1).repeatForever(autoreverses: false), value: isAnimating)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    WorkoutStartView(workout: "Running", selectedGenres: ["Rock", "Pop"])
}
