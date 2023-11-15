//
//  ToolbarSaveButton.swift
//  GiftMaster
//
//  Created by Malte Ruff on 06.11.23.
//

import SwiftUI

struct ToolbarSaveButton: View {
	var text = "Save"
	var disabledWhen: Bool
	
	var whenSaved: () -> Void = {}
	
	@Environment(\.dismiss) private var dismiss
	
	var body: some View {
		Button {
			withAnimation {
				whenSaved()
				dismiss()
			}
		} label: {
			Text(text)
				.fontWeight(.bold)
		}
		.disabled(disabledWhen)
	}
}
