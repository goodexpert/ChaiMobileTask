//
//  ContentView.swift
//  ChaiMobileTask
//
//  Created by Seongwuk Park on 23/05/22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: TaskViewModel
    @State var isVisibleRemovePopup: Bool = false
    @State var taskEntity: TaskEntity? = nil
    @FocusState private var focusedField: ObjectIdentifier?
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.white.edgesIgnoringSafeArea(.all)
                
                ScrollView {
                    if viewModel.taskEntities.isEmpty {
                        emptyTaskView()
                    } else {
                        LazyVStack {
                            ForEach(viewModel.taskEntities) { taskEntity in
                                TaskItemView(taskEntity) {
                                    withAnimation(.easeInOut) {
                                        self.isVisibleRemovePopup.toggle()
                                        self.taskEntity = taskEntity
                                    }
                                }
                            }
                        }
                    }
                }
                .onTapGesture {
                    focusedField = nil
                }
                
                if let taskEntity = self.taskEntity, isVisibleRemovePopup {
                    PopupDeleteAlert(taskEntity) { isConfirmed in
                        withAnimation {
                            if isConfirmed {
                                viewModel.delete(taskEntity)
                            }
                            isVisibleRemovePopup.toggle()
                        }
                    }
                }
            }
            .onAppear {
                viewModel.fetch()
            }
            .navigationBarTitle("", displayMode: .large)
            .navigationBarItems(
                leading:
                    Text("appTitle").font(.system(size: 17, weight: .bold)),
                trailing:
                    Button(action: {
                        viewModel.addTask(title: "newTask".localized)
                    }) {
                        Image("img_add")
                            .frame(width: 48, height: 48, alignment: .center)
                            .scaledToFit()
                    }
            )
        }
        .navigationViewStyle(.columns)
    }
    
    @ViewBuilder
    private func emptyTaskView() -> some View {
        HStack(alignment: .center) {
            Text("noTaskMessage".localized)
                .font(.system(size: 17, weight: .bold))
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                .padding(20)
        }
        .accessibilityIdentifier("emptyTaskView")
        .background(Color(red: 0.9, green: 0.9, blue: 0.9))
        .cornerRadius(16)
        .frame(minWidth: 0, maxWidth: .infinity)
        .padding(.horizontal, 24)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AppComponent.shared.viewModel)
    }
}
