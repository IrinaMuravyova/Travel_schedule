//
//  RoutesListView.swift
//  Travel_schedule
//
//  Created by Irina Muravyeva on 26.06.2026.
//

import SwiftUI

struct RoutesListView: View {
    @ObservedObject var viewModel: RoutesViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack (alignment: .bottom) {
            VStack (spacing: 16) {
                Text("\(viewModel.from) -> \(viewModel.to)")
                    .frame(width: 343, height: 87)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundStyle(.blackDay)
                
                if viewModel.isSearching {
                    // Индикатор загрузки
                    ProgressView("Поиск маршрутов...")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if let routes = viewModel.routes {
                    
                    List(routes.segments, id: \.id) { route in
                        RoutesRowView()
                    }
                    .listStyle(.plain)
                } else {
                    // Состояние когда нет маршрутов
                    Text("Маршруты не найдены")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .foregroundStyle(.gray)
                }
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
//    RoutesListView()
}
