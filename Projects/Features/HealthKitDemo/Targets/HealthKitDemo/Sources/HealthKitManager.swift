//
//  HealthKitManager.swift
//  HealthKitDemo
//
//  Created by 정건호 on 7/21/25.
//  Copyright © 2025 tuist.io. All rights reserved.
//

import Foundation
import HealthKit

final class HealthKitManager {
    static let shared = HealthKitManager()
    private let healthStore = HKHealthStore()
    
    // MARK: - 権限のリクエスト
    func requestAuthorization(completion: @escaping (Bool) -> Void) {
        guard HKHealthStore.isHealthDataAvailable() else {
            completion(false)
            return
        }

        guard let stepType = HKQuantityType.quantityType(forIdentifier: .stepCount) else {
            completion(false)
            return
        }

        let readTypes: Set = [stepType]

        healthStore.requestAuthorization(toShare: nil, read: readTypes) { success, _ in
            completion(success)
        }
    }
    
    // MARK: - 今日の歩数を取得
    func fetchTodayStepCount(completion: @escaping (Double) -> Void) {
        guard let stepType = HKQuantityType.quantityType(forIdentifier: .stepCount) else {
            completion(0)
            return
        }

        let startOfDay = Calendar.current.startOfDay(for: Date())
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: Date(), options: .strictStartDate)

        let query = HKStatisticsQuery(quantityType: stepType, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, result, _ in
            guard let sum = result?.sumQuantity() else {
                completion(0)
                return
            }

            let stepCount = sum.doubleValue(for: HKUnit.count())
            completion(stepCount)
        }

        healthStore.execute(query)
    }
}
