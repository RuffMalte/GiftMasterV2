//
//  ModifyGiftWithButtonView.swift
//  GiftMaster
//
//  Created by Malte Ruff on 07.11.23.
//

import SwiftUI

struct ModifyGiftWithButtonView: View {
	
	var isNewGift: Bool = false
	@Bindable var gift: GiftModel
	var onSave: ((GiftModel) -> Void)?
	
	@State private var isPresented = false
	
    var body: some View {
		Button {
			isPresented.toggle()
		} label: {
			if isNewGift {
				Label("Add new Gift", systemImage: "gift.fill")
			} else {
				Label("Edit this Gift", systemImage: "pencil")
			}
		}
		.sheet(isPresented: $isPresented) {
			ModifyGiftSheetView(isNewGift: isNewGift, gift: gift, onSave: onSave)
		}
    }
}

