//
//  ModfiyPersonWithButtonView.swift
//  GiftMaster
//
//  Created by Malte Ruff on 06.11.23.
//

import SwiftUI

struct ModfiyPersonWithButtonView: View {
	
	var isNewPerson: Bool = false
	@Bindable var person: PersonModel
	
	@State private var isPresented = false
	
    var body: some View {
		Button {
			isPresented.toggle()
		} label: {
			if isNewPerson {
				Label("Add Person", systemImage: "plus")
			} else {
				Label("Edit Person", systemImage: "pencil")
			}
		}
		.sheet(isPresented: $isPresented) {
			ModifyPersonSheetView(isNewPerson: isNewPerson, person: person)
		}
    }
}
