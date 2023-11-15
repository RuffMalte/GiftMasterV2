//
//  TextFieldWithRevertButton.swift
//  GiftMasterV2
//
//  Created by Malte Ruff on 10.09.23.
//

import SwiftUI


struct TextFieldWithRevertButton: View {
	
	@Binding var text: String
	@State var useTextEditror: Bool = false
	
	var textFieldDescription: String = ""
	@State var textCharacterLimit: Int = 20
	
	
	@State private var originalText: String = ""
	@State private var showRevertButton: Bool = false
	
	var body: some View {
		HStack {
			
			if useTextEditror {
				TextEditor(text: $text)
					.lineLimit(2)
					.frame(height: 100)
			} else {
				TextField(textFieldDescription, text: $text)
				
			}
			
			Spacer()
			
			
			if showRevertButton {
				Button {
					withAnimation {
						text = originalText
						showRevertButton = false
					}
				} label: {
					Image(systemName: "arrow.uturn.left")
						.fontWeight(.bold)
				}
				.buttonStyle(.borderedProminent)
			}
		}
		.onAppear {
			originalText = text
		}
		.onChange(of: text) { oldValue, newValue in
			
			// Limit text to textCharacterLimit
			text = String(text.prefix(textCharacterLimit))
			
			if newValue != originalText {
				withAnimation {
					showRevertButton = true
				}
			} else {
				withAnimation {
					showRevertButton = false
				}
			}
		}
		
	}
}

#Preview {
	@State var text = "Hello World"
	return TextFieldWithRevertButton(text: $text, textFieldDescription: "World")
}
