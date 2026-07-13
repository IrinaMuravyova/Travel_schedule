//
//  StoriesView.swift
//  Travel_schedule
//
//  Created by Irina Muravyeva on 26.06.2026.
//

import SwiftUI

struct StoriesView: View {
    private let imageBorderWidth: CGFloat = 4
    private let samplesImage: [Image] = [Image(.stories1), Image(.stories2), Image(.stories3), Image(.stories4)]
    var body: some View {
        LazyHGrid(rows: [GridItem(.fixed(140))]) {
            ForEach(0..<samplesImage.count, id: \.self) { index in
                ZStack (alignment: .bottomLeading) {
                    ZStack(alignment: .center) {
                        RoundedRectangle(cornerRadius: 16) .fill(.blueUniversal).frame(width: 92, height: 140)
                        
                        samplesImage[index]
                            .resizable()
                            .scaledToFit()
                            .frame(width: 92 - imageBorderWidth * 2, height: 140 - imageBorderWidth * 2)
                            .cornerRadius(16)
                    }
                    
                    Text("Text Text Text Text Text Text Text Text Text")
                        .frame(width: 76, height: 45, alignment: .leading)
                        .font(.system(size: 12, weight: .regular))
                        .foregroundStyle(.white)
                        .tracking(0.4)
                        .lineLimit(3)
                        .multilineTextAlignment(.leading)
                        .padding(.horizontal, 8)
                        .padding(.bottom, 12)
                }
            }
        }
        .frame(height: 188)
    }
}

#Preview {
    StoriesView()
}
