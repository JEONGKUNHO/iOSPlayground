import ProjectDescription

let project = Project(
  name: "HealthKitDemo",
  targets: [
    Target(
      name: "HealthKitDemo",
      platform: .iOS,
      product: .app,
      bundleId: "com.kunho.HealthKitDemo",
      deploymentTarget: .iOS(targetVersion: "17.0", devices: [.iphone]),
      infoPlist: .default,
      sources: ["Targets/HealthKitDemo/Sources/**"],
      resources: ["Targets/HealthKitDemo/Resources/**"],
      entitlements: "HealthKitDemo.entitlements",
      dependencies: [
        .sdk(name: "HealthKit", type: .framework)
      ]
    ),
    Target(
      name: "HealthKitDemoTests",
      platform: .iOS,
      product: .unitTests,
      bundleId: "com.kunho.healthkitdemo.tests",
      infoPlist: .default,
      sources: ["Targets/HealthKitDemo/Tests/**"],
      dependencies: [.target(name: "HealthKitDemo")]
    )
  ]
)
