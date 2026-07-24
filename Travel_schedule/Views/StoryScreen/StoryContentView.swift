//
//  StoryContentView.swift
//  Travel_schedule
//
//  Created by Irina Muravyeva on 13.07.2026.
//

import SwiftUI
import Combine

struct StoryContentView: View {
    struct Configuration {
        let timerTickInternal: TimeInterval
        let progressPerTick: CGFloat
        
        init(
            storiesCount: Int,
            secondsPerStory: TimeInterval = 5,
            timerTickInternal: TimeInterval = 0.05
        ) {
            self.timerTickInternal = timerTickInternal
            self.progressPerTick = 1.0 / CGFloat(storiesCount) / secondsPerStory * timerTickInternal
        }
    }
    
    private let stories: [Story]
    private let configuration: Configuration
    private let startIndex: Int
    
    private var currentStory: Story { stories[currentStoryIndex] }
    private var currentStoryIndex: Int { Int(progress * CGFloat(stories.count)) }
    
    @State private var progress: CGFloat = 0
    @State private var timer: Timer.TimerPublisher = Timer.publish(every: 5, on: .main, in: .common)
    @State private var cancellable: Cancellable?
    
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var storyViewState: StoryViewState
    
    init(
        stories: [Story] = [ .story1, .story2, .story3 ],
        startIndex: Int = 0,
        storyViewState: StoryViewState
    ) {
        self.stories = stories
        self.startIndex = min(startIndex, stories.count - 1)
        self.storyViewState = storyViewState
        configuration = Configuration(storiesCount: stories.count)
        timer = Self.createTimer(configuration: configuration)
        
        _progress = State(initialValue: CGFloat(self.startIndex) / CGFloat(stories.count))
    }
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            StoryView(story: currentStory)
            
            ProgressBar(numberOfSections: stories.count, progress: progress)
                .padding(.init(top: 28, leading: 12, bottom: 12, trailing: 12))
            
            CloseButton(action: { dismiss() })
                .ignoresSafeArea()
                .padding(.top, 50)
                .padding(.trailing, 12)
        }
        .onAppear {
            timer = Self.createTimer(configuration: configuration)
            cancellable = timer.connect()
        }
        .onDisappear {
            cancellable?.cancel()
        }
        .onReceive(timer) { _ in
            timerTick()
        }
        .onTapGesture {
            nextStory()
            resetTimer()
        }
        .gesture(
            DragGesture(minimumDistance: 20)
                .onEnded { value in
                    handleSwipe(value)
                }
        )
        .onChange(of: currentStoryIndex) { _, newIndex in
            guard stories.indices.contains(newIndex) else { return }
            storyViewState.markAsViewed(stories[newIndex])
        }
    }
    
    private func timerTick() {
        var nextProgress = progress + configuration.progressPerTick
        if nextProgress >= 1 {
            nextProgress = 0
        }
        progress = nextProgress
    }
    
    private func nextStory() {
        let storiesCount = stories.count
        let currentStoryIndex = Int(progress * CGFloat(storiesCount))
        let nextStoryIndex = currentStoryIndex + 1 < storiesCount ? currentStoryIndex + 1 : 0
        
        withAnimation {
            progress = CGFloat(nextStoryIndex) / CGFloat(storiesCount)
        }
    }
    
    private func resetTimer() {
        cancellable?.cancel()
        timer = Self.createTimer(configuration: configuration)
        cancellable = timer.connect()
    }
    
    private static func createTimer(configuration: Configuration) -> Timer.TimerPublisher {
        Timer.publish(every: configuration.timerTickInternal, on: .main, in: .common)
    }
    
    private func handleSwipe(_ value: DragGesture.Value) {
        let horizontal = value.translation.width
        let vertical = value.translation.height
        
        guard abs(horizontal) > abs(vertical) else { return }
        
        if horizontal < -50 {
            nextStory()
        } else if horizontal > 50 {
            previousStory()
        }
        
        resetTimer()
    }
    
    private func previousStory() {
        let storiesCount = stories.count
        let currentIndex = Int(progress * CGFloat(storiesCount))
        
        let previousIndex: Int
        
        if currentIndex == 0 {
            previousIndex = storiesCount - 1
        } else {
            previousIndex = currentIndex - 1
        }
        
        withAnimation {
            progress = CGFloat(previousIndex) / CGFloat(storiesCount)
        }
    }
}
