//
//  IntrestListView.swift
//  GiftMaster
//
//  Created by Malte Ruff on 05.11.23.
//

import SwiftUI
import SwiftData

struct IntrestListView: View {
	
	@Query(sort: \IntrestModel.name, animation: .bouncy) var intrests: [IntrestModel]
	@Environment(\.modelContext) private var modelContext

	
    var body: some View {
		NavigationStack {
			Form {
				Section {
					Text("Intrests")
				}
				
				Section {
					ForEach(intrests) { intrest in
						NavigationLink {
							IntrestDetailView(intrest: intrest)
						} label: {
							IntrestCellView(intrest: intrest)
						}

					}
				}
			}
			
			.toolbar {
				ToolbarItem(placement: .primaryAction) {
					ModifyIntrestWithButtonView(isNewIntrest: true, intrest: IntrestModel(name: "", icon: "tag")) { IntrestModel in
						modelContext.insert(IntrestModel)
					}
				}
			}
		}
    }
}
