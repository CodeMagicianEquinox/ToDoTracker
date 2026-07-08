//
//  GroupStatsView.swift
//  ToDoTracker
//
//  Created by Tim Terrance on 6/24/26.
//

import SwiftUI

struct GroupStatsView: View {
    var tasks: [TaskItem]
    var accent: Color = .cyan
    var secondaryAccent: Color = .brown
    
    // calculation of completion tasks
    var completedCount: Int {tasks.filter { $0.isCompleted}.count}
    
    // calculation of percentage
    var progress: Double { tasks.isEmpty ? 0 : Double(completedCount) / Double(tasks.count)}
    
    var body: some View {
        ViewThatFits(in: .horizontal) {
            statsRow(showsProgressCircle: true)
            statsRow(showsProgressCircle: false)
        }
    }

    private func statsRow(showsProgressCircle: Bool) -> some View {
        HStack(spacing: 20) {
            if showsProgressCircle {
                ZStack {
                    Circle()
                        .stroke(accent.opacity(0.18), lineWidth: 10)
                    
                    // Completed Circle
                    Circle()
                        .trim(from: 0.0, to: progress)
                        .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round))
                        .foregroundStyle(accent)
                        .rotationEffect(.degrees(-90))
                        
                    Text("\(Int((progress * 100).rounded()))%")
                        .font(.caption)
                        .bold()
                }
                .frame(width: 54, height: 54)
            }
            
            // Text Info
            VStack(alignment: .leading, spacing: 3) {
                Text("Progress of my tasks")
                    .font(.headline)
                    .foregroundStyle(secondaryAccent)
                Text("\(completedCount) / \(tasks.count) completed")
                    .font(.title2)
                    .bold()
            }
            
            Spacer()
        }
    }
}
