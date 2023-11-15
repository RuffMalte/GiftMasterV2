//
//  ModifyMakerSheetView.swift
//  GiftMaster
//
//  Created by Malte Ruff on 07.11.23.
//

import SwiftUI
import SwiftData

struct ModifyMakerSheetView: View {
	
	var isNewMaker: Bool = false
	
	@Query(sort: \MakerModel.name, animation: .bouncy) var makers: [MakerModel]
	@Environment(\.modelContext) private var modelContext
	
	@Bindable var maker: MakerModel
	var onSave: ((MakerModel) -> Void)?
	
    var body: some View {
		NavigationStack {
			Form {
				Section {
					TextFieldWithRevertButton(text: $maker.name, textFieldDescription: "Maker Name", textCharacterLimit: 30)
				} header: {
					Text("Maker Information")
				}
			}
			.toolbar {
				ToolbarItem(placement: .cancellationAction) {
					ToolbarCancelButton(Whencanceled: {
						print("Canceled")
					})
				}
				ToolbarItem(placement: .confirmationAction) {
					ToolbarSaveButton(disabledWhen: maker.name.isEmpty, whenSaved: {
						if isNewMaker {
							withAnimation {
								modelContext.insert(maker)
								onSave?(maker)
							}
						}
					})
				}
			}
		}
    }
}
