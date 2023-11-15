//
//  GiftDetailView.swift
//  GiftMaster
//
//  Created by Malte Ruff on 04.11.23.
//

import SwiftUI

struct GiftDetailView: View {
	
	@Bindable var gift: GiftModel
	
	@State var newMakerString: String = ""
	
    var body: some View {
		Form {
			Section {
				Text(gift.id.uuidString)
			}
			
			Section {
				TextField("Name", text: $gift.name)
				TextField("Notes", text: $gift.notes)
			}
			
			Section {
				GetMakerByIdView(id: gift.makerId)
			}
		}
    }
}
