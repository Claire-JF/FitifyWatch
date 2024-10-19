//
//  ContentView.swift
//  FitifyWatch Watch App
//
//  Created by Annie Trieu on 10/17/24.
//

import SwiftUI

struct ContentView: View {
    @State private var isAnimating = false
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ZStack {
                    Color.customBackground.edgesIgnoringSafeArea(.all)
                    
                    VStack(spacing: 10) {
                        Text("Welcome to")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.customBlack)
                        
                        Text("Fitify")
                            .font(.system(size: 28, weight: .heavy))
                            .foregroundColor(.customRed)
                            .scaleEffect(isAnimating ? 1.1 : 1.0)
                            .animation(Animation.easeInOut(duration: 1.5).repeatForever(autoreverses: true), value: isAnimating)
                        
                        ZStack {
                            Circle()
                                .fill(Color.customOrange)
                                .frame(width: geometry.size.width * 0.4, height: geometry.size.width * 0.4)
                                .shadow(color: .customDarkOrange.opacity(0.3), radius: 5, x: 0, y: 3)
                            
                            Image(systemName: "figure.run")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: geometry.size.width * 0.25, height: geometry.size.width * 0.25)
                                .foregroundColor(.customBackground)
                                .rotationEffect(.degrees(isAnimating ? 360 : 0))
                                .animation(Animation.linear(duration: 10).repeatForever(autoreverses: false), value: isAnimating)
                        }
                        .padding(.vertical, 5)
                        
                        HStack(spacing: 15) {
                            NavigationLink(destination: GymView()) {
                                WorkoutButton(title: "Gym", icon: "dumbbell.fill", color: .customRed, size: geometry.size.width * 0.2)
                            }
                            
                            NavigationLink(destination: Text("Calm View")) {
                                WorkoutButton(title: "Calm", icon: "leaf.fill", color: .customDarkOrange, size: geometry.size.width * 0.2)
                            }
                        }
                        
                        Text("Choose your workout style")
                            .font(.system(size: 12))
                            .foregroundColor(.customBlack.opacity(0.7))
                            .padding(.top, 5)
                    }
                    .padding(.horizontal)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                }
            }
        }
        .onAppear {
            isAnimating = true
        }
    }
}

struct WorkoutButton: View {
    let title: String
    let icon: String
    let color: Color
    let size: CGFloat
    
    var body: some View {
        VStack(spacing: 5) {
            Image(systemName: icon)
                .font(.system(size: size * 0.6))
                .foregroundColor(.customBackground)
                .frame(width: size, height: size)
                .background(color)
                .clipShape(Circle())
                .shadow(color: color.opacity(0.3), radius: 3, x: 0, y: 2)
            
            Text(title)
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(.customBlack)
        }
    }
}

#Preview {
    ContentView()
}
