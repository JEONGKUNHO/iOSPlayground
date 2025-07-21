//
//  ContentView.swift
//  HealthKitDemo
//
//  Created by 정건호 on 7/21/25.
//  Copyright © 2025 tuist.io. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var stepCount: Double = 0
    @State private var authorized: Bool = false

    var body: some View {
        VStack(spacing: 30) {
            if authorized {
                Text("本日の歩数")
                    .font(.headline)
                Text("\(Int(stepCount)) 歩")
                    .font(.largeTitle)
                    .bold()
            } else {
                VStack(spacing: 10) {
                    Text("健康データを取得するには許可が必要です。")
                        .multilineTextAlignment(.center)

                    Button("健康情報を取得") {
                        HealthKitManager.shared.requestAuthorization { success in
                            DispatchQueue.main.async {
                                authorized = success
                                if success {
                                    HealthKitManager.shared.fetchTodayStepCount { steps in
                                        DispatchQueue.main.async {
                                            stepCount = steps
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .clipShape(Capsule())
                }
            }
        }
        .padding()
    }
}
