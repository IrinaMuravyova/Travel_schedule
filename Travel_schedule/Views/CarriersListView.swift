//
//  CarriersListView.swift
//  Travel_schedule
//
//  Created by Irina Muravyeva on 26.06.2026.
//

import SwiftUI

struct CarriersListView: View {
    var body: some View {
        ZStack (alignment: .bottom) {
            VStack (spacing: 16) {
                Text("Moscow (Yaroslavskiy station)" + " -> " + " St.Peterburg(Baltiyskiy station)")
                    .frame(width: 343, height: 87)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundStyle(.blackDay)
                
                List(/*viewModel.carriers*/) { /*carrier in*/
                    ZStack {
                        RoundedRectangle(cornerRadius: 24)
                            .fill(.lightGray)
                        
                        VStack(alignment: .leading) {
                            HStack(spacing: 8) {
                                Image(.brandIcon /*viewModel.logo*/)
                                    .resizable()
                                    .frame(width: 38, height: 38)
                                    .cornerRadius(12)
                                
                                VStack (alignment: .leading) {
                                    Text("РЖД")
                                        .font(.system(size: 17, weight: .regular))
                                        .tracking(-0.41)
                                    Text("С пересадкой в Пекине")
                                        .foregroundStyle(.red)
                                        .frame(alignment: .bottom)
                                        .font(.system(size: 12, weight: .regular))
                                        .tracking(0.4)
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                
                                Text("14 января")
                                    .frame(alignment: .topTrailing)
                                    .font(.system(size: 12))
                                    .tracking(0.4)
                            }
                            .padding(EdgeInsets(top: 14, leading: 14, bottom: 2, trailing: 14))
                            
                            HStack {
                                Text("22:30")
                                    .frame(width: 46, height: 20)
                                    .tracking(-0.41)
                                
                                TimeSeparatorView()
                                
                                Text("20 часов")
                                    .frame(width: 56, height: 14)
                                    .font(.system(size: 12))
                                    .tracking(0.4)
                                
                                TimeSeparatorView()
                                
                                Text("08:05")
                                    .frame(width: 46, height: 20)
                                    .tracking(-0.41)
                            }
                            .padding(EdgeInsets(top: 2, leading: 14, bottom: 14, trailing: 14))
                        }
                    }
                    .listRowSeparator(.hidden)
                }
                .listStyle(.plain)
            }
            
            Button("Уточнить время") {
                
            }
            .frame(width: 343, height: 60)
            .background(.blue)
            .cornerRadius(16)
            .foregroundStyle(.white)
            .font(.system(size: 17, weight: .bold))
        }
    }
}

#Preview {
    CarriersListView()
}
