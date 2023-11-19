import Foundation
import SwiftUI

// private var selectedStyle: UIImpactFeedbackGenerator.FeedbackStyle = .light

#if os(iOS)
class Haptics {
	
	
	func playFeedbackHaptic(_ style: UIImpactFeedbackGenerator.FeedbackStyle) {
		let generator = UIImpactFeedbackGenerator(style: style)
		generator.impactOccurred()
	}
	
	
	func playNotificationHaptic(_ type: UINotificationFeedbackGenerator.FeedbackType) {
		let generator = UINotificationFeedbackGenerator()
		generator.notificationOccurred(type)
	}
}
#endif

