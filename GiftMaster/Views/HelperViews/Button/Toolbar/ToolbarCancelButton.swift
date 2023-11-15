//
//  ToolbarCancelButton.swift
//  GiftMaster
//
//  Created by Malte Ruff on 06.11.23.
//

import SwiftUI

struct ToolbarCancelButton: View {
	
	@State var text = "Cancel"
	
	var Whencanceled: () -> Void = {}
	
	@Environment(\.dismiss) private var dismiss
	
    var body: some View {
		Button {
			Whencanceled()
			dismiss()
		} label: {
			Text("Cancel")
				.fontWeight(.bold)
		}

    }
}

#Preview {
    ToolbarCancelButton()
}
