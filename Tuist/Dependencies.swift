import ProjectDescription

let dependencies = Dependencies(
	swiftPackageManager: [
		.remote(url: "https://github.com/layoutBox/PinLayout", requirement: .exact("1.10.4")),
	],
	platforms: [.iOS]
)
