//
//  ModifyMakerWithButtonView.swift
//  GiftMaster
//
//  Created by Malte Ruff on 07.11.23.
//

import SwiftUI

struct ModifyMakerWithButtonView: View {
	
	
	var isNewMaker: Bool = false
	@Bindable var maker: MakerModel
	
	var onSave: ((MakerModel) -> Void)?
	
	@State private var isPresented = false

	
    var body: some View {
		Button {
			isPresented.toggle()
		} label: {
			if isNewMaker {
				Label("Add Maker", systemImage: "door.right.hand.closed")
			} else {
				Label("Edit Maker", systemImage: "pencil")
			}
		}
		.sheet(isPresented: $isPresented) {
			ModifyMakerSheetView(isNewMaker: isNewMaker, maker: maker, onSave: onSave)
		}
    }
}
