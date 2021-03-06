//
//  HistoryListView.swift
//  Recall
//
//  Created by 俞清源 on 2020/2/28.
//  Copyright © 2020 俞清源. All rights reserved.
//

import SwiftUI

struct ListViewCell: View {
    @State var viewModel: EventViewModel
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @State private var action: Int?
    
    var body: some View {
        Button(action: {
            self.action = 0
        }) {
            ZStack {
                NavigationLink(destination: HistoryDetailMainView(viewModel: viewModel), tag: 0, selection: $action) {
                    EmptyView()
                }
                
                IntroCellView(viewModel: viewModel)
                    .shadow(color: self.colorScheme == .light ? Color(UIColor.systemGray3) : .clear, radius: 6, x: 0, y: 5)
            }
        }
        .buttonStyle(PlainButtonStyle())
        .frame(width: nil, height: 140, alignment: .center)
        .padding([.top, .bottom], 8)
    }
}

struct HistoryListView: View {
    @ObservedObject var viewModel: EventListViewModel
    
    var body: some View {
        List(viewModel.events) {
            ListViewCell(viewModel: $0)
        }
        .alert(isPresented: $viewModel.error, content: {
            Alert(title: Text("请求出现未知错误,请重试"))
        })
        .onAppear {
            UITableView.appearance().separatorStyle = .none
        }
    }
}

struct MainView: View {
    @ObservedObject var viewModel = EventListViewModel()
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottomTrailing) {
                HistoryListView(viewModel: viewModel)
                
                ReloadButton(isLoading: $viewModel.loading) {
                    self.viewModel.fetch()
                }
                .shadow(radius: 10)
                .offset(x: -20, y: -20)
            }
            .navigationBarTitle(Text("历史上的今天"), displayMode: .automatic)
            .navigationBarItems(trailing: NavigationLink(destination: UserSettingView(), label: {
                Image(systemName: "gear")
            }))
        }
        .onAppear {
            DispatchQueue.main.async {
                self.viewModel.fetch()
            }
        }
    }
}

#if DEBUG
struct HistoryListView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
#endif
