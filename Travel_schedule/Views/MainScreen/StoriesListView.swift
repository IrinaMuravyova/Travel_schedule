//
//  StoriesListView.swift
//  Travel_schedule
//
//  Created by Irina Muravyeva on 26.06.2026.
//

import SwiftUI

struct StoriesListView: View {
    private let imageBorderWidth: CGFloat = 4
    private let stories: [Story] = [
        .story1,
        .story2,
        .story3,
        .story4
    ]
    
    @Binding var selectedStory: Story?
    
    @ObservedObject var storyViewState: StoryViewState
    
    var body: some View {
        LazyHGrid(rows: [GridItem(.fixed(140))]) {
            ForEach(stories) { story in
                ZStack (alignment: .bottomLeading) {
                    ZStack(alignment: .center) {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(storyViewState.isViewed(story) ? .clear : .blueUniversal)
                            .frame(width: 92, height: 140)
                        
                        story.image
                            .resizable()
                            .scaledToFit()
                            .frame(
                                width: storyViewState.isViewed(story) ? 92 : 92 - imageBorderWidth * 2,
                                height: storyViewState.isViewed(story) ? 140 : 140 - imageBorderWidth * 2)
                            .cornerRadius(16)
                            .opacity(storyViewState.isViewed(story) ? 0.5 : 1)
                    }
                    
                    Text(story.description)
                        .frame(width: 76, height: 45, alignment: .leading)
                        .font(.system(size: 12, weight: .regular))
                        .foregroundStyle(.white)
                        .tracking(0.4)
                        .lineLimit(3)
                        .multilineTextAlignment(.leading)
                        .padding(.horizontal, 8)
                        .padding(.bottom, 12)
                }
                .onTapGesture {
                    selectedStory = story
                    storyViewState.markAsViewed(story)
                }
                .fullScreenCover(item: $selectedStory) { story in
                    if let index = stories.firstIndex(where: { $0.id == story.id }) {
                        StoryContentView(
                            stories: stories,
                            startIndex: index,
                            storyViewState: storyViewState
                        )
                    } else {
                        StoryContentView(
                            stories: stories,
                            storyViewState: storyViewState
                        )
                    }
                }
            }
        }
        .frame(height: 188)
    }
}

