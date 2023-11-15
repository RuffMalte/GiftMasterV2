//
//  ContentView.swift
//  GiftMaster
//
//  Created by Malte Ruff on 04.11.23.
//

import SwiftUI
import SwiftData

struct ContentView: View {
	
	var tempOverlay: TempOverlayViewModel = TempOverlayViewModel()
	
    var body: some View {
		ZStack {
			MainTabView()
				.environment(tempOverlay)
			
		}
    }
}
