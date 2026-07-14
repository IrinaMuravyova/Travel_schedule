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
    
    var body: some View {
        LazyHGrid(rows: [GridItem(.fixed(140))]) {
            ForEach(stories) { story in
                ZStack (alignment: .bottomLeading) {
                    ZStack(alignment: .center) {
                        RoundedRectangle(cornerRadius: 16) .fill(.blueUniversal).frame(width: 92, height: 140)
                        
                        story.image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 92 - imageBorderWidth * 2, height: 140 - imageBorderWidth * 2)
                            .cornerRadius(16)
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
                }
                .fullScreenCover(item: $selectedStory) { story in
                    if let index = stories.firstIndex(where: { $0.id == story.id }) {
                        StoryContentView(stories: stories, startIndex: index)
                    } else {
                        StoryContentView(stories: stories)
                    }
                }
            }
        }
        .frame(height: 188)
    }
}
