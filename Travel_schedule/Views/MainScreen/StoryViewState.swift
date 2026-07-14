//
//  StoryViewState.swift
//  Travel_schedule
//
//  Created by Irina Muravyeva on 14.07.2026.
//

import SwiftUI
import Combine

final class StoryViewState: ObservableObject {
    @AppStorage("viewedStories") private var viewedStoriesData: Data = Data()
    @Published private(set) var viewedStories: Set<StoryID> = []
    
    init() {
        load()
    }
    
    func markAsViewed(_ story: Story) {
        viewedStories.insert(story.id)
        save()
    }
    
    func isViewed(_ story: Story) -> Bool {
        viewedStories.contains(story.id)
    }
    
    private func load() {
        viewedStories =
        (try? JSONDecoder().decode(Set<StoryID>.self, from: viewedStoriesData))
        ?? []
    }
    
    private func save() {
        viewedStoriesData =
        (try? JSONEncoder().encode(viewedStories))
        ?? Data()
    }
}
