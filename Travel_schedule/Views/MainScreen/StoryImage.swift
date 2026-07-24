//
//  StoryImage.swift
//  Travel_schedule
//
//  Created by Irina Muravyeva on 14.07.2026.
//

import SwiftUI

struct StoryImage: View {
    let story: Story

    var body: some View {
        switch story.id {
        case .story1: Image(.stories1)
        case .story2: Image(.stories2)
        case .story3: Image(.stories3)
        case .story4: Image(.stories4)
        }
    }
}
