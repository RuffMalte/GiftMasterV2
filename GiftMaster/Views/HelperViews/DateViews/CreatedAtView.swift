//
//  CreatedAtView.swift
//  GiftMaster
//
//  Created by Malte Ruff on 11.11.23.
//

import SwiftUI

struct CreatedAtView: View {
	@State var date: Date
	var body: some View {
		HStack {
			Spacer()
			Text("Created at \(date, style: .date)")
				.font(.system(.footnote, design: .monospaced))
				.foregroundStyle(.secondary)
			Spacer()
		}
	}
}
