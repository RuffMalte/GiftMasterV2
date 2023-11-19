//
//  PopupViewModifier.swift
//  GiftMaster
//
//  Created by Malte Ruff on 12.11.23.
//

import SwiftUI

struct PopoverViewModifier<PopoverContent>: ViewModifier where PopoverContent: View {
	@State private var isPresented: Bool = false
	let popoverContent: () -> PopoverContent
	
	func body(content: Content) -> some View {
		content
			.onTapGesture {
				self.isPresented = true
				Haptics().playFeedbackHaptic(.light)
			}
			.popover(isPresented: $isPresented, content: popoverContent)
	}
}

extension View {
	func popover<PopoverContent>(@ViewBuilder content: @escaping () -> PopoverContent) -> some View where PopoverContent: View {
		modifier(PopoverViewModifier(popoverContent: content))
	}
}
