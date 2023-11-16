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
	var mainButtonAction: () -> Void
	
	@Binding var isPresented: Bool
	
	var body: some View {
		Image(systemName: swipeButtonImage)
			.foregroundColor(buttonColor ?? .accentColor)
			.swipeActions {
				Button(role: buttonRole) {
					isPresented = true
				} label: {
					Label(mainButtonText, systemImage: swipeButtonImage)
				}
			}
			.confirmationDialog(title, isPresented: $isPresented) {
				Button("Cancel", role: .cancel) {
					isPresented = false
				}
				Button(mainButtonText, role: .destructive) {
					mainButtonAction()
					isPresented = false
				}
			} message: {
				Text("This action cannot be undone.")
			}
	}
}



