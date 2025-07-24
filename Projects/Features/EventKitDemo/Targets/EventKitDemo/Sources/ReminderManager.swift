//
//  ReminderManager.swift
//  EventKitDemo
//
//  Created by 정건호 on 7/24/25.
//

import Foundation
import EventKit

struct Reminder: Identifiable {
    let id = UUID()
    let title: String
    let isCompleted: Bool
}

@MainActor
class ReminderManager: ObservableObject {
    private let eventStore = EKEventStore()
    @Published var reminders: [Reminder] = []
    @Published var accessDenied = false
    
    func requestAccess(completion: @escaping () -> Void) {
        eventStore.requestFullAccessToReminders { granted, error in
            Task {
                if granted {
                    completion()
                } else {
                    self.accessDenied = true
                }
            }
        }
    }
    
    func fetchReminders(for date: Date) {
        let predicate = eventStore.predicateForReminders(in: nil)
        eventStore.fetchReminders(matching: predicate) { ekReminders in
            let calendar = Calendar.current
            let startOfDay = calendar.startOfDay(for: date)
            let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!
            
            let result: [Reminder] = ekReminders?.compactMap { item in
                guard let dueDate = item.dueDateComponents?.date else { return nil }
                guard dueDate >= startOfDay && dueDate < endOfDay else { return nil }
                return Reminder(title: item.title, isCompleted: item.isCompleted)
            } ?? []
            
            Task {
                self.reminders = result
            }
        }
    }
}
