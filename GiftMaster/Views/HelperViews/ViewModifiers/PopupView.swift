//
//  PopupView.swift
//  GiftMaster
//
//  Created by Malte Ruff on 12.11.23.
//

import SwiftUI

struct PopupView<Content>: View where Content: View {

	var showPopovers: Bool
	
	let content: () -> Content

	//TODO: find a better way to do this... please.......

    var body: some View {
		if showPopovers {
			RoundedRectangle(cornerRadius: 10)
				.foregroundStyle(.quinary.opacity(0.01))
				.popover {
					content()
						.padding()
						.presentationCompactAdaptation(.none)
				}
		}
    }
}
