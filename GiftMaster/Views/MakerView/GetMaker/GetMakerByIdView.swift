//
//  GetMakerByIdView.swift
//  GiftMaster
//
//  Created by Malte Ruff on 05.11.23.
//

import SwiftUI
import SwiftData

struct GetMakerByIdView: View {
	
	@State var id: UUID
	
	@Query(sort: \MakerModel.name, animation: .bouncy) var makers: [MakerModel]
	@Environment(\.modelContext) private var modelContext
	
	@State var maker: MakerModel?
	
    var body: some View {
		VStack {
			if let maker = maker {
				MakerCellView(maker: maker)
			} else {
				EmptyView()
			}
		}
		.onAppear { getMakerById() }
    }
	
	func getMakerById() {
		for maker in makers {
			
			if maker.id == id {
				self.maker = maker
			}
		}
	}
}
