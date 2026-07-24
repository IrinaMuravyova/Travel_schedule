//
//  StoryView.swift
//  Travel_schedule
//
//  Created by Irina Muravyeva on 13.07.2026.
//

import SwiftUI

struct StoryView: View {
    let story: Story
    
    var body: some View {
        GeometryReader { geometry in
            let screenWidth = geometry.size.width
            story.image
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .overlay(alignment: .bottomLeading) {
                    VStack {
                        VStack(alignment: .leading, spacing: 16) {
                            Text(story.title)
                                .font(.system(size: 34, weight: .bold))
                                .tracking(0.4)
                                .foregroundStyle(.white)
                                .lineLimit(2)
                            
                            Text(story.description)
                                .font(.system(size: 20, weight: .regular))
                                .tracking(0.4)
                                .foregroundStyle(.white)
                                .lineLimit(3)
                        }
                        .frame(maxWidth: screenWidth)
                        .padding(.bottom, 40)
                    }
                }
        }
    }
}

#Preview {
    StoryView(story: .story1)
}
