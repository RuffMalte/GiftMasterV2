//
//  TempOverlayViewModel.swift
//  GiftMaster
//
//  Created by Malte Ruff on 12.11.23.
//

import SwiftUI
import Observation
import Combine

@Observable
class TempOverlayViewModel: ObservableObject {
	
	var isPresented: Bool = false
	var overlay: AnyView?
	
	private var cancellable: AnyCancellable?
	
	func show<Content: View>(@ViewBuilder content: @escaping () -> Content) {
		overlay = AnyView(
			content()
				.opacity(isPresented ? 1 : 0)
		)
		
		// First, show the overlay
		withAnimation(.easeIn(duration: 0.25)) {
			isPresented = true
		}
		
		// Then, after a delay, start the hide animation
		DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
			withAnimation(.easeOut(duration: 0.25)) {
				self.isPresented = false
			}
			
			// Finally, after the hide animation duration, remove the overlay content
			DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
				self.overlay = nil
			}
		}
	}
}

