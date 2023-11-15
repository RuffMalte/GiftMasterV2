//
//  ConfirmationDialogModifier.swift
//  GiftMaster
//
//  Created by Malte Ruff on 11.11.23.
//

import SwiftUI

struct ConfirmationDialogModifier: ViewModifier {
	let title: String
	let message: String
	let confirmAction: () -> Void
	
	@State private var showConfirmationDialog = false
	
	func body(content: Content) -> some View {
		content
			.onTapGesture {
				self.showConfirmationDialog = true
			}
			.confirmationDialog(title, isPresented: $showConfirmationDialog, titleVisibility: .visible) {
				Button("Yes", action: confirmAction)
				Button("Cancel", role: .cancel) {}
			} message: {
				Text(message)
			}
	}
}

extension View {
	func confirmationDialog(title: String, message: String, confirmAction: @escaping () -> Void) -> some View {
		self.modifier(ConfirmationDialogModifier(title: title, message: message, confirmAction: confirmAction))
	}
}
