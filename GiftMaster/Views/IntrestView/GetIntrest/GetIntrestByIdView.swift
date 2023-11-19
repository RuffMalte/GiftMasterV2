//
//  GetIntrestByIdView.swift
//  GiftMaster
//
//  Created by Malte Ruff on 05.11.23.
//

import SwiftUI
import SwiftData

enum IntrestsDisplayMode {
	case navLink
	case forSelection((IntrestModel) -> Void)
	case forSelectionNoXmark
	case normal
	case small(Bool?)
}

struct GetIntrestByIdView: View {
	
	@State var id: UUID
	var displayMode: IntrestsDisplayMode = .navLink
	
	@Query(sort: \IntrestModel.name, animation: .bouncy) var intrests: [IntrestModel]
	@Environment(\.modelContext) private var modelContext
	
	@State var intrest: IntrestModel?
	
	var body: some View {
		VStack {
			if let intrest = intrest {
				switch displayMode {
				case .navLink:
					NavigationLink {
						IntrestDetailView(intrest: intrest)
					} label: {
						IntrestCellView(intrest: intrest)
					}
				case .forSelection(let completionHandler):
					IntrestCellForSelectionView(intrest: intrest, onXmarkPress: completionHandler)
					
				case .forSelectionNoXmark:
					IntrestCellForSelectionView(intrest: intrest)
					
					
				case .normal:
					IntrestCellView(intrest: intrest)
					
				case .small(let isMatching):
					if let isMatching = isMatching {
						IntrestSmallCellView(intrest: intrest, isMatching: isMatching)
					} else {
						IntrestSmallCellView(intrest: intrest)
					}
					
				}
			}
		}
		.onAppear { getIntrestById() }
	}
	
	func getIntrestById() {
		for interest in intrests {
			if interest.id == id {
				self.intrest = interest
				break 
			}
		}
	}
}

