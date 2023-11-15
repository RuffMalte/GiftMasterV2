//
//  IntrestDetailView.swift
//  GiftMaster
//
//  Created by Malte Ruff on 05.11.23.
//

import SwiftUI

struct IntrestDetailView: View {
	
	@Bindable var intrest: IntrestModel
	
	
    var body: some View {
		Form {
			Section {
				TextField("Name", text: $intrest.name)
			}
		}
		
    }
}

