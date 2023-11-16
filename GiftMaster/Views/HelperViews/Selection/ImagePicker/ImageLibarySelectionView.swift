//
//   ImageLibarySelectionView.swift
//  GiftMaster
//
//  Created by Malte Ruff on 15.11.23.
//

import SwiftUI
import PhotosUI

struct ImageLibarySelectionView: View {
	
	@State var selectedItems: [PhotosPickerItem] = []
	@Binding var data: [Data]
	
	@State private var showingActionSheet = false
	@State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
	@State private var showImageLibrary = false
	@State private var isImagesLoaded = false
	
	
	var body: some View {
		VStack {
			LazyVGrid(columns: [ GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 5) {
				ForEach(data.indices, id: \.self) { index in
					if let uiimage = UIImage(data: data[index]) {
						
						Menu {
							//TODO: Quick View of the image
							
							Button(role: .destructive) {
								data.remove(at: index)
								selectedItems.remove(at: index)
							} label: {
								Label("Delete", systemImage: "trash.fill")
							}
						} label: {
							ImageCellView(uiimage: uiimage, data: $data, index: index)
						}
						
					}
				}
				if data.count < 9 {
					PhotosPicker(
						selection: $selectedItems,
						maxSelectionCount: 3 - data.count, // Limit selection to fill up to 3 images
						matching: .images
					) {
						Image(systemName: "photo.fill")
							.font(.largeTitle)
							.background(content: {
								RoundedRectangle(cornerRadius: 10)
									.frame(width: 100, height: 100)
									.foregroundStyle(.thinMaterial)
								
							})
							.frame(width: 100, height: 100)
					}
				}
			}
			.onChange(of: selectedItems) { oldValue, newValue in
				if !isImagesLoaded {
					for item in selectedItems {
						item.loadTransferable(type: Data.self) { result in
							switch result {
							case .success(let loadedData):
								if let loadedData = loadedData, let uiimage = UIImage(data: loadedData), let compressedImageData = uiimage.jpegData(compressionQuality: 0.2) {
									self.data.append(compressedImageData)
									print(data.first!)
								} else {
									print("data is nil")
								}
							case .failure(let failure):
								fatalError("\(failure)")
							}
						}
					}
					isImagesLoaded = true
				}
			}
		}
	}
}
