//
//  ChooseDirectionsView.swift
//  Travel_schedule
//
//  Created by Irina Muravyeva on 24.06.2026.
//

import SwiftUI

struct ChooseDirectionsView: View {
    @State var from: String = ""
    @State var to: String = ""
    
    var body: some View {
        VStack(spacing: 20) {
            ScrollView(.horizontal, showsIndicators: false) {
                StoriesView()
                    .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 0))
            }
            
            ZStack(alignment: .center) {
                RoundedRectangle(cornerRadius: 20)
                    .fill(.blueUniversal)
                    .frame(width: 343, height: 128)
                
                HStack(spacing: 16) {
                    VStack(alignment: .leading) {
                        
                        InputView(direction: from, promt: "Откуда")
                        
                        InputView(direction: to, promt: "Куда")
                    }
                    .background(.white)
                    .cornerRadius(20)
                    
                    Button(action: {}) {
                        Image(.сhange)
                            .renderingMode(.template)
                            .resizable()
                            .frame(width: 24, height: 24)
                            .tint(.blueUniversal)
                    }
                    .frame(width: 36, height: 36)
                    .background(.white)
                    .cornerRadius(20)
                }
                .padding(16)
            }
            
            Spacer()
        }
    }
}

#Preview {
    ChooseDirectionsView()
}
