//
//  Story.swift
//  Travel_schedule
//
//  Created by Irina Muravyeva on 13.07.2026.
//

import SwiftUI

enum StoryID: String, Codable {
    case story1
    case story2
    case story3
    case story4
}

struct Story: Identifiable {
    let id: StoryID
    let image: Image
    let title: String
    let description: String
    
    static let story1 = Story(
        id: StoryID.story1,
        image: Image(.stories1),
        title: "🎉 ⭐️ ❤️",
        description: "Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 "
    )
    
    static let story2 = Story(
        id: StoryID.story2,
        image: Image(.stories2),
        title: "😍 🌸 🥬",
        description: "Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 "
    )
    
    static let story3 = Story(
        id: StoryID.story3,
        image: Image(.stories3),
        title: "🧀 🥑 🥚",
        description: "Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 "
    )
    
    static let story4 = Story(
        id: StoryID.story4,
        image: Image(.stories4),
        title: "🧀 🥑 🥚",
        description: "Text4 Text4 Text4 Text4 Text4 Text4 Text4 Text4 Text4 Text4 Text4 Text4 Text4 Text4 Text4 Text4 Text4 "
    )
}
