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
	
	@Query(sort: \GiftModel.name, animation: .bouncy) var gifts: [GiftModel]
	@Environment(\.modelContext) private var modelContext
	
	@State var gift: GiftModel?
	
	var body: some View {
		VStack {
			if let gift = gift {
				NavigationLink {
					ModifyGiftSheetView(gift: gift)
						.navigationBarBackButtonHidden()
						.navigationTitle(gift.name)
				} label: {
					GiftCellView(gift: gift)
				}
				
			} else {
				EmptyView()
			}
		}
		.onAppear {
			getGiftById()
		}
		
	}
	
	
	func getGiftById() {
		for gift in gifts {
			
			if gift.id == id {
				self.gift = gift
			}
		}
	}
}
