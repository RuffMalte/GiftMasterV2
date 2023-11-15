//
//  ModifyIntrestWithButtonView.swift
//  GiftMaster
//
//  Created by Malte Ruff on 07.11.23.
//

import SwiftUI

struct ModifyIntrestWithButtonView: View {
	
	var isNewIntrest: Bool = false
	@Bindable var intrest: IntrestModel
	
	var onSave: ((IntrestModel) -> Void)?
	
	@State private var isPresented = false
	
    var body: some View {
		Button {
			isPresented.toggle()
		} label: {
			if isNewIntrest {
				Label("Add Intrest", systemImage: "tag.fill")
			} else {
				Label("Edit Intrest", systemImage: "pencil")
			}
		}
		.sheet(isPresented: $isPresented) {
			ModifyIntrestSheetView(isNewIntrest: isNewIntrest, intrest: intrest, onSave: onSave)
		}
    }
}

