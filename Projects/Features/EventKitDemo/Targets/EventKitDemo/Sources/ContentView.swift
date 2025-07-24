//
//  ContentView.swift
//  EventKitDemo
//
//  Created by 정건호 on 7/22/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var manager = ReminderManager()
    @State private var selectedDate = Date()
    @State private var showAlert = false
    
    var body: some View {
        VStack(spacing: 16) {
            DatePicker(String(), selection: $selectedDate, displayedComponents: .date)
                .datePickerStyle(.compact)
                .labelsHidden()
                .clipped()
            
            Button("リマインダーを取得する") {
                if manager.accessDenied {
                    showAlert = true
                } else {
                    manager.requestAccess {
                        manager.fetchReminders(for: selectedDate)
                    }
                }
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 24)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            .alert(String(), isPresented: $showAlert) {
                Button("キャンセル", role: .cancel) { }
                Button("設定へ移動") {
                    if let url = URL(string: UIApplication.openSettingsURLString),
                       UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url)
                    }
                }
            } message: {
                Text("リマインダーへのアクセス権限を設定してください。")
            }
            
            if manager.accessDenied {
                VStack {
                    Spacer()
                    Text("リマインダーへのアクセスが拒否されました。")
                        .foregroundColor(.red)
                    Spacer()
                }
            } else if manager.reminders.isEmpty {
                VStack {
                    Spacer()
                    Text("リマインダーがありません。")
                    Spacer()
                }
            } else {
                List(manager.reminders) { reminder in
                    HStack {
                        Text(reminder.title)
                        Spacer()
                        Image(systemName: reminder.isCompleted ? "checkmark.circle.fill" : "circle")
                            .foregroundColor(reminder.isCompleted ? .green : .gray)
                    }
                }
            }
            
            Spacer()
        }
    }
}
