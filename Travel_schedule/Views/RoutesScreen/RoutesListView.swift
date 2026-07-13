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
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        ZStack (alignment: .bottom) {
            VStack (spacing: 16) {
                Text("\(viewModel.from) -> \(viewModel.to)")
                    .frame(width: 343, height: 87)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundStyle(colorScheme == .dark ? .white : .blackDay)
                
                if viewModel.isSearching {
                    ProgressView("Searching routes...")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    List {
                        if viewModel.displayedSegments.isEmpty {
                            Text("Routes don't found")
                                .foregroundStyle(.gray)
                                .frame(maxWidth: .infinity)
                                .listRowSeparator(.hidden)
                        } else {
                            ForEach(
                                viewModel.displayedSegments.indices,
                                id: \.self) { index in
                                let route = viewModel.displayedSegments[index]
                                
                                RoutesRowView(route: route)
                                    .padding(.horizontal, 0)
                            }
                        }
                        
                        if viewModel.isLoadingMore {
                            HStack {
                                Spacer()
                                ProgressView()
                                Spacer()
                            }
                        }
                    }
                    .listStyle(.plain)
                    .onAppear {
                        viewModel.loadMore()
                    }
                }
            }
            
            NavigationLink {
                FiltersView(
                    selectedTimeSlots: $viewModel.selectedTimeSlots,
                    transferFilter: $viewModel.transferFilter
                )
            } label: {
                Text("Narrow time")
                    .frame(maxWidth: .infinity, minHeight: 60)
                    .background(.blueUniversal)
                    .cornerRadius(16)
                    .foregroundStyle(.white)
                    .font(.system(size: 17, weight: .bold))
            }
            .buttonStyle(.plain)
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 53)
        .toolbar(.hidden, for: .tabBar)
        .onAppear {
            UITabBar.appearance().isHidden = true
        }
        .onDisappear {
            UITabBar.appearance().isHidden = false
        }
        .onChange(of: viewModel.displayedSegments.count) { oldValue, newValue in
            if newValue < 3 && viewModel.hasMorePages {
                viewModel.loadMore()
            }
        }
    }
}
