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
    @State private var isFromActive = false
    @State private var isToActive = false
    
    var body: some View {
        NavigationStack {
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
                            
                            Button {
                                isFromActive = true
                            } label: {
                                InputView(
                                    direction: $from,
                                    promt: NSLocalizedString("From", comment: "")
                                )
                            }
                            .buttonStyle(.plain)
                            
                            Button {
                                isToActive = true
                            } label: {
                                InputView(
                                    direction: $to,
                                    promt: NSLocalizedString("To", comment: "")
                                )
                            }
                            .buttonStyle(.plain)
                        }
                        .background(.white)
                        .cornerRadius(20)
                        
                        Button(action: {
                            let temp = from
                            from = to
                            to = temp
                        }) {
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
                
                if !from.isEmpty && !to.isEmpty {
                    HStack {
                        Spacer()
                        
                        Button("Find") {
                            //TODO: add action
                        }
                        .frame(width: 150, height: 60)
                        .background(.blueUniversal)
                        .cornerRadius(16)
                        .foregroundStyle(.white)
                        .font(.system(size: 17, weight: .bold))
                        
                        Spacer()
                    }
                    Spacer()
                } else {
                    Spacer()
                }
            }
            .navigationDestination(isPresented: $isFromActive) {
                CitiesListView(
                    selectedCity: $from,
                    isActive: $isFromActive
                )
            }
            .navigationDestination(isPresented: $isToActive) {
                CitiesListView(
                    selectedCity: $to,
                    isActive: $isToActive
                )
            }
        }
    }
}
