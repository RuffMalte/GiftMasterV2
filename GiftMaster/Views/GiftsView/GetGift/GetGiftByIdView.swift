//
//  GetGiftByIdView.swift
//  GiftMaster
//
//  Created by Malte Ruff on 04.11.23.
//

import SwiftUI
import SwiftData

struct GetGiftByIdView: View {
	
	@State var id: UUID
		
	var matchingParentIntrrests: [UUID]?

	
	@Query(sort: \GiftModel.name, animation: .bouncy) var gifts: [GiftModel]
	@Environment(\.modelContext) private var modelContext
	
	@State var gift: GiftModel?
	
	var onNotFound: (UUID?) -> Void = { _ in }
	
	
	var body: some View {
		VStack {
			if let gift = gift {
				NavigationLink {
					ModifyGiftSheetView(gift: gift)
						.navigationBarBackButtonHidden()
						.navigationTitle(gift.name)
				} label: {
					if let matchingParentIntrrests = matchingParentIntrrests {
						GiftCellView(gift: gift, matchingParentIntrrests: matchingParentIntrrests) { giftID in
							onNotFound(giftID)
						}
					} else {
						GiftCellView(gift: gift) { giftID in
							onNotFound(giftID)
						}
					}
					
					
				}
			}
		}
		
		.onAppear {
			getGiftById()
		}
		
	}
	
	
	func getGiftById() {
		if let foundGift = gifts.first(where: { $0.id == id }) {
			self.gift = foundGift
		} else {
			onNotFound(id)
		}
	}
}
