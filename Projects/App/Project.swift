import ProjectDescription

let project = Project(
  name: "App",
  targets: [
    Target(
      name: "App",
      platform: .iOS,
      product: .app,
      bundleId: "com.kunho.app",
      deploymentTarget: .iOS(targetVersion: "17.0", devices: [.iphone]),
      infoPlist: .default,
      sources: ["Targets/App/Sources/**"],
      resources: ["Targets/App/Resources/**"],
      dependencies: [
      ]
    ),
    Target(
      name: "AppTests",
      platform: .iOS,
      product: .unitTests,
      bundleId: "com.kunho.app.tests",
      infoPlist: .default,
      sources: ["Targets/App/Tests/**"],
      dependencies: [.target(name: "App")]
    )
  ]
)
