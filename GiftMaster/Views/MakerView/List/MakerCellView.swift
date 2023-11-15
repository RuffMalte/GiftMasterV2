//
//  MakerCellView.swift
//  GiftMaster
//
//  Created by Malte Ruff on 05.11.23.
//

import SwiftUI

struct MakerCellView: View {
	
	@Bindable var maker: MakerModel
	
	@State private var isEditSheetPresented: Bool = false

    var body: some View {
		VStack {
			Text(maker.name)
				.font(.system(.footnote, design: .rounded, weight: .bold))
				.padding(4)
				.foregroundStyle(.white)
				.background {
					RoundedRectangle(cornerRadius: 5)
						.foregroundStyle(maker.color.toColor.gradient)
				}
		}
		
		
		.contextMenu {
			Button {
				isEditSheetPresented.toggle()
			} label: {
				Label("Edit this Maker", systemImage: "pencil")
			}
		}
		.sheet(isPresented: $isEditSheetPresented) {
			ModifyMakerSheetView(isNewMaker: false, maker: maker)
		}
    }
}
