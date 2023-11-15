//
//  ImageCellView.swift
//  GiftMaster
//
//  Created by Malte Ruff on 15.11.23.
//

import SwiftUI

struct ImageCellView: View {
	
	@State var uiimage: UIImage
	@Binding var data: [Data]
	@State var index: Int
	
	@State private var showingDetail = false
	
	var body: some View {
		Image(uiImage: uiimage)
			.resizable()
			.aspectRatio(contentMode: .fill)
			.frame(width: 100, height: 100)
			.clipShape(RoundedRectangle(cornerRadius: 10))
		
		
	}
}
