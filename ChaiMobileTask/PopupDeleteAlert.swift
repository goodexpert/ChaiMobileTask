//
//  PopupDeleteAlert.swift
//  ChaiMobileTask
//
//  Created by Seongwuk Park on 25/05/22.
//

import SwiftUI

struct PopupDeleteAlert: View {
    @ObservedObject private var taskEntity: TaskEntity
    @State private var isConfirm: Bool = false
    @State private var isVisible: Bool = false
    
    private let onDisappear: (Bool) -> Void
    
    init(_ taskEntity: TaskEntity, onDisappear: @escaping (Bool) -> Void) {
        self.taskEntity = taskEntity
        self.onDisappear = onDisappear
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color.black.opacity(0.3).edgesIgnoringSafeArea(.all)
            
            if isVisible {
                VStack {
                    HStack {
                        Image("ic_handle")
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding(.top, 10)
                            .padding(.bottom, 30)
                    }
                    .background(RoundedRectangleShape(corners: [.topLeft, .topRight], radius: 20).fill(.white))

                    VStack(alignment: .center) {
                        Spacer()
                            .frame(height: 20)
                        
                        Image("ic_notice_72")

                        Text(String(format: "removeMessage".localized, taskEntity.title ?? "newTask".localized))
                            .font(.system(size: 20, weight: .bold))
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 40)
                            .padding(.vertical, 10)
                        
                        Button(action: {
                            dismiss(true)
                        }) {
                            Text("ok".localized)
                                .font(.system(size: 14, weight: .bold))
                                .foregroundColor(.white)
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .frame(height: 60)
                        }
                        .accessibilityIdentifier("okayButton")
                        .background(Color.black)
                        .cornerRadius(20)
                        .padding(.vertical, 20)
                        .padding(.horizontal, 40)
                    }
                    .background(Color.white)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .onDisappear {
                        onDisappear(isConfirm)
                    }
                }
                .transition(.move(edge: .bottom))
            }
        }
        .onAppear {
            withAnimation {
                isVisible = true
            }
        }
        .onTapGesture {
            dismiss()
        }
    }
    
    private func dismiss(_ isConfirm: Bool = false) {
        withAnimation {
            self.isVisible = false
            self.isConfirm = isConfirm
        }
    }
}

struct PopupDialogView_Previews: PreviewProvider {
    static var previews: some View {
        PopupDeleteAlert(AppComponent.taskEntity) { _ in
            // TODO: Nothing
        }
    }
}
