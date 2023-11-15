//
//  IntrestsSmallListView.swift
//  GiftMaster
//
//  Created by Malte Ruff on 11.11.23.
//

import SwiftUI

struct IntrestsSmallListView: View {
	
	@Binding var interestIds: [UUID]

	var showXButton: Bool
	
    var body: some View {
		ScrollView(.horizontal, showsIndicators: false) {
			HStack(spacing: 10) {
				ForEach(interestIds, id: \.self) { interestId in
					Group {
						if showXButton {
							GetIntrestByIdView(
								id: interestId,
								displayMode: .forSelection { selectedInterest in
									if let index = interestIds.firstIndex(of: selectedInterest.id) {
										withAnimation {
											interestIds.remove(at: index)
										}
									}
								}
							)
						} else {
							GetIntrestByIdView(id: interestId, displayMode: .forSelectionNoXmark)
							
						}
						
					}
					
					.background(Color(uiColor: UIColor.systemBackground))
					.cornerRadius(10)
					.shadow(color: .secondary.opacity(0.4), radius: 3.5)
					

				}
				
			}
			.padding(5)
		
			
			.scrollBounceBehavior(.basedOnSize)
			.scrollTargetLayout(isEnabled: true)
		}

    }
}
