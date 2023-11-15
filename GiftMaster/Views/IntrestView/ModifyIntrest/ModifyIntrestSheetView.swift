//
//  ModifyIntrestSheetView.swift
//  GiftMaster
//
//  Created by Malte Ruff on 07.11.23.
//

import SwiftUI
import SwiftData

struct ModifyIntrestSheetView: View {
	
	var isNewIntrest: Bool = false
	
	@Query(sort: \IntrestModel.name, animation: .bouncy) var intrests: [IntrestModel]
	@Environment(\.modelContext) private var modelContext
	
	@Bindable var intrest: IntrestModel
	var onSave: ((IntrestModel) -> Void)?
	
	var body: some View {
		NavigationStack {
			Form {
				Section {
					TextFieldWithRevertButton(text: $intrest.name, textFieldDescription: "Intrest Name", textCharacterLimit: 15)
				} header: {
					Text("Intrest Information")
				}
			}
			.toolbar {
				ToolbarItem(placement: .cancellationAction) {
					ToolbarCancelButton(Whencanceled: {
						print("Canceled")
					})
				}
				ToolbarItem(placement: .confirmationAction) {
					ToolbarSaveButton(disabledWhen: intrest.name.isEmpty, whenSaved: {
						if isNewIntrest {
							withAnimation {
								modelContext.insert(intrest)
								onSave?(intrest)
							}
						}
					})
				}
				
			}
		}
	}
}
