//
//  IntrestCellView.swift
//  GiftMaster
//
//  Created by Malte Ruff on 05.11.23.
//

import SwiftUI
import SwiftData

struct IntrestCellView: View {
	
	@Bindable var intrest: IntrestModel
	
	@Query(sort: \IntrestModel.name, animation: .bouncy) var intrests: [IntrestModel]
	@Environment(\.modelContext) private var modelContext
	
	@State private var isEditSheetPresented: Bool = false
	@State private var isDeleteSheetPresented: Bool = false


    var body: some View {
        Text(intrest.name)
			.contextMenu {
				Button {
					isEditSheetPresented.toggle()
				} label: {
					Label("Edit this Intrest", systemImage: "pencil")
				}
				
				Button(role: .destructive) {
					isDeleteSheetPresented.toggle()
				} label: {
					Label("Delete this Intrest", systemImage: "trash.fill")
				}
			}
			.sheet(isPresented: $isEditSheetPresented) {
				ModifyIntrestSheetView(intrest: intrest)
			}
			.confirmationDialog("Are you sure?", isPresented: $isDeleteSheetPresented, titleVisibility: .visible) {
				Button(role: .destructive) {
					modelContext.delete(intrest)
				} label: {
					Text("Yes")
				}
				
				Button("Cancel", role: .cancel) {}
			}
    }
}
