import ProjectDescription

let swiftLintScriptBody = "SwiftLint/swiftlint"
var swiftLintScript = TargetScript.post(script: swiftLintScriptBody, name: "SwiftLint", basedOnDependencyAnalysis: false)
var scripts = [swiftLintScript]

let target = Target(
	name: "MdEditor",
	platform: .iOS,
	product: .app,
	productName: "MdEditor",
	bundleId: "ru.koloma.MdEditor",
	deploymentTarget: .iOS(
		targetVersion: "15.0",
		devices: .iphone
	),
	infoPlist: "MdEditor/SupportingFiles/Info.plist",
	sources: ["MdEditor/Sources/**"],
	resources: ["MdEditor/Resources/**"],
	scripts: scripts,
	dependencies: [
		.external(name: "PinLayout")
	]
)

let testTarget = Target(
	name: "MdEditorTests",
	platform: .iOS,
	product: .unitTests,
	bundleId: "ru.koloma.MdEditorTests",
	deploymentTarget: .iOS(
		targetVersion: "15.0",
		devices: .iphone
	),
	sources: ["MdEditorTests/Sources/**"],
	dependencies: [
		.target(name: "MdEditor")
	]
)

let project = Project(
	name: "MdEditor",
	organizationName: "ChervotkinaTeam",
	targets: [target, testTarget],
	schemes: [
		Scheme(
			name: "MdEditor",
			shared: true,
			buildAction: .buildAction(targets: ["MdEditor"]),
			testAction: .targets(["MdEditorTests"]),
			runAction: .runAction(executable: "MdEditor")
		),
		Scheme(
			name: "MdEditorTests",
			shared: true,
			buildAction: .buildAction(targets: ["MdEditorTests"]),
			testAction: .targets(["MdEditorTests"]),
			runAction: .runAction(executable: "MdEditorTests")
		)
	]
)
