//
//  TaskItemView.swift
//  ChaiMobileTask
//
//  Created by Seongwuk Park on 23/05/22.
//

import SwiftUI

struct TaskItemView: View {
    @EnvironmentObject var viewModel: TaskViewModel
    
    @ObservedObject private var taskEntity: TaskEntity
    @State private var isEditing: Bool = false
    @State private var title: String
    @FocusState var focusedField: ObjectIdentifier?
    
    private let onDelete: (() -> Void)
    
    init(_ taskEntity: TaskEntity, onDelete: @escaping () -> Void) {
        self.taskEntity = taskEntity
        self.title = taskEntity.title ?? ""
        self.onDelete = onDelete
    }
    
    var body: some View {
        HStack(alignment: .center) {
            Button(action: {
                taskEntity.isDone = !taskEntity.isDone
                viewModel.save()
                viewModel.fetch()
            }) {
                Image(taskEntity.isDone ? "ic_checked_24" : "ic_checkbox_24")
            }
            .padding(.leading, 18)
            .padding(.vertical, 18)
            
            if isEditing {
                TextField("newTask".localized, text: $title, onCommit: onCommit)
                    .background(isEditing ? .white : .clear)
                    .focused($focusedField, equals: taskEntity.id)
                    .font(.system(size: 17, weight: .bold))
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    .lineLimit(1)
                    .padding(.leading, 6)
            } else {
                Text(taskEntity.title ?? "newTask".localized)
                    .font(.system(size: 17, weight: .bold))
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    .lineLimit(1)
                    .padding(.leading, 6)
            }
            
            Button(action: {
                isEditing.toggle()
                focusedField = isEditing ? taskEntity.id : nil
                if !isEditing {
                    onCommit()
                }
            }) {
                Image("ic_edit_48")
                    .frame(minWidth: 36, minHeight: 36)
            }
            .padding(.leading, 16)
            
            Button(action: {
                onDelete()
            }) {
                Image("ic_delete_48")
                    .frame(minWidth: 36, minHeight: 36)
            }
            .padding(.trailing, 20)
        }
        .background(Color(red: 0.9, green: 0.9, blue: 0.9))
        .cornerRadius(16)
        .frame(minWidth: 0, maxWidth: .infinity)
        .padding(.horizontal, 24)
    }
    
    private func onCommit() {
        taskEntity.title = title
        viewModel.save()
        isEditing = false
    }
}

struct TaskItemView_Previews: PreviewProvider {
    static var previews: some View {
        TaskItemView(AppComponent.taskEntity) {
            // TODO: Nothing
        }
    }
}
