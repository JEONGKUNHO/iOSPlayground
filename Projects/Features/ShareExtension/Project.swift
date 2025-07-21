import ProjectDescription

let project = Project(
  name: "ShareExtension",
  targets: [
    Target(
      name: "ShareExtension",
      platform: .iOS,
      product: .app,
      bundleId: "com.kunho.shareextension",
      deploymentTarget: .iOS(targetVersion: "17.0", devices: [.iphone]),
      infoPlist: .default,
      sources: ["Targets/ShareExtension/Sources/**"],
      resources: ["Targets/ShareExtension/Resources/**"],
      dependencies: []
    ),
    Target(
      name: "ShareExtensionTests",
      platform: .iOS,
      product: .unitTests,
      bundleId: "com.kunho.shareextension.tests",
      infoPlist: .default,
      sources: ["Targets/ShareExtension/Tests/**"],
      dependencies: [.target(name: "ShareExtension")]
    )
  ]
)
