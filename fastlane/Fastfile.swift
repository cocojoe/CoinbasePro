// This file contains the fastlane.tools configuration
// You can find the documentation at https://docs.fastlane.tools
//
// For a list of all available actions, check out
//
//     https://docs.fastlane.tools/actions
//

import Foundation

class Fastfile: LaneFile {
    
    func bootstrapLane() {
        desc("Bootstrap")
        carthage(command: "bootstrap", platform: "iOS", cacheBuilds: true)
    }
    
	func testLane() {
		desc("Run tests")
        runTests(project: "CoinbasePro.xcodeproj", scheme: "CoinbasePro.iOS", device: "iPhone 8", clean: true, codeCoverage: true)
	}
}
