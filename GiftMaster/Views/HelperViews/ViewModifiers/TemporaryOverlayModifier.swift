//
//  TemporaryOverlayModifier.swift
//  GiftMaster
//
//  Created by Malte Ruff on 12.11.23.
//

import SwiftUI

struct TemporaryOverlayModifier: ViewModifier {
	@State private var isShowing: Bool = true
	
	let text: String
	let delay: TimeInterval
	
	func body(content: Content) -> some View {
		ZStack {
			content
			if isShowing {
				Text(text)
					.padding()
					.background(Color.black.opacity(0.7))
					.foregroundColor(Color.white)
					.cornerRadius(10)
					.transition(.opacity)
					.onAppear {
						DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
							withAnimation {
								isShowing = false
							}
						}
					}
			}
		}
	}
}

extension View {
	func temporaryOverlay(text: String, delay: TimeInterval = 1.0) -> some View {
		self.modifier(TemporaryOverlayModifier(text: text, delay: delay))
	}
}
