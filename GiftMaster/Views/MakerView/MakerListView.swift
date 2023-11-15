//
//  MakerListView.swift
//  GiftMaster
//
//  Created by Malte Ruff on 05.11.23.
//

import SwiftUI
import SwiftData

struct MakerListView: View {
	
	@Query(sort: \MakerModel.name, animation: .bouncy) var makers: [MakerModel]
	@Environment(\.modelContext) private var modelContext
	
	
    var body: some View {
		NavigationStack {
			Form {
				Section {
					Button {
						modelContext.insert(MakerPreviewItems().getDefaultMaker())
					} label: {
						Label("Add Maker", systemImage: "plus")
					}

				}
				
				Section {
					ForEach(makers) { maker in
						MakerCellView(maker: maker)
					}
				}
			}
		}
    }
}
