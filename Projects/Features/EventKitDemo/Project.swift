import ProjectDescription

let project = Project(
  name: "EventKitDemo",
  targets: [
    Target(
      name: "EventKitDemo",
      platform: .iOS,
      product: .app,
      bundleId: "com.kunho.EventKitDemo",
      deploymentTarget: .iOS(targetVersion: "17.0", devices: [.iphone]),
      infoPlist: .file(path: "Targets/EventKitDemo/Info.plist"),
      sources: ["Targets/EventKitDemo/Sources/**"],
      resources: ["Targets/EventKitDemo/Resources/**"],
      dependencies: [
      ]
    ),
    Target(
      name: "EventKitDemoTests",
      platform: .iOS,
      product: .unitTests,
      bundleId: "com.kunho.eventkitdemo.tests",
      infoPlist: .default,
      sources: ["Targets/EventKitDemo/Tests/**"],
      dependencies: [.target(name: "EventKitDemo")]
    )
  ]
)
