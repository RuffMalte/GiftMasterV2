//
//  SwipeActionsConfirmationView.swift
//  GiftMaster
//
//  Created by Malte Ruff on 15.11.23.
//

import SwiftUI

struct SwipeActionsConfirmationView: View {
	
	var swipeButtonImage: String
	var buttonRole: ButtonRole
	var buttonColor: Color?
	
	var title: String
	var mainButtonText: String
	let message: String = "This action can not be undone."
	let mainButtonAction: () -> Void
	
	@State private var isPresented: Bool = false

	
	var body: some View {
		
		Button(role: buttonRole) {
			isPresented = true
		} label: {
			Image(systemName: swipeButtonImage)
				.foregroundColor(buttonColor ?? .accentColor)
		}
		.confirmationDialog(title, isPresented: $isPresented) {
			Button {
				isPresented = false
			} label: {
				Text("Cancel")
			}
			
			Button(role: .destructive) {
				mainButtonAction()
			} label: {
				Text(mainButtonText)
			}
	
			
			
		} message: {
			Text(message)
		}
	}
}

