//
//  PersonModel.swift
//  GiftMaster
//
//  Created by Malte Ruff on 04.11.23.
//

import Foundation
import SwiftData


@Model
class PersonModel {
	@Attribute(.unique) var id: UUID
	
	var firstName: String
	var lastName: String
	var pronouns: String
	var birthday: Date
	
	var icon: String
	var color: ColorEnum
	var notes: String
	var creationDate: Date
	var isFavorite: Bool

	var giftIds: [UUID]
	
	var likedGenresIds: [UUID]
	var dislikedGenreIds: [UUID]
	
	
	init(id: UUID = UUID(), firstName: String, lastName: String, pronouns: String, birthday: Date = Date.now, icon: String = SFIcons().PersonIcons[0].systemImageName, color: ColorEnum = .red, notes: String = "", creationDate: Date = Date.now, isFavorite: Bool = false, giftIds: [UUID] = [], likedGenresIds: [UUID] = [], dislikedGenreIds: [UUID] = []) {
		self.id = id
		self.firstName = firstName
		self.lastName = lastName
		self.pronouns = pronouns
		self.birthday = birthday
		self.icon = icon
		self.color = color
		self.notes = notes
		self.creationDate = creationDate
		self.isFavorite = isFavorite
		self.giftIds = giftIds
		self.likedGenresIds = likedGenresIds
		self.dislikedGenreIds = dislikedGenreIds
	}
	
	func copy() -> PersonModel {
		return PersonModel(id: id, firstName: firstName, lastName: lastName, pronouns: pronouns, birthday: birthday, icon: icon, color: color, notes: notes, creationDate: creationDate, isFavorite: isFavorite, giftIds: giftIds, likedGenresIds: likedGenresIds, dislikedGenreIds: dislikedGenreIds)
	}
	
	func update(secondPerson: PersonModel) {
		self.id = secondPerson.id
		self.firstName = secondPerson.firstName
		self.lastName = secondPerson.lastName
		self.pronouns = secondPerson.pronouns
		self.birthday = secondPerson.birthday
		self.icon = secondPerson.icon
		self.color = secondPerson.color
		self.notes = secondPerson.notes
		self.creationDate = secondPerson.creationDate
		self.isFavorite = secondPerson.isFavorite
		self.giftIds = secondPerson.giftIds
		self.likedGenresIds = secondPerson.likedGenresIds
		self.dislikedGenreIds = secondPerson.dislikedGenreIds
	}
	
	//https://stackoverflow.com/questions/59348783/how-calculate-days-to-person-birthday-with-swift
	var daysTillBirthday: Int {
		let cal = Calendar.current
		let today = cal.startOfDay(for: Date())
		let date = cal.startOfDay(for: birthday)
		let components = cal.dateComponents([.day, .month], from: date)
		let nextDate = cal.nextDate(after: today, matching: components, matchingPolicy: .nextTimePreservingSmallerComponents)
		return cal.dateComponents([.day], from: today, to: nextDate ?? today).day ?? 0
	}
	
	var calculateAge: Int {
		let calendar: Calendar = Calendar.current
		let now = Date()
		let ageComponents = calendar.dateComponents([.year], from: birthday, to: now)
		let age = ageComponents.year!
		return age
	}
	
	var timeUntilBirthdayInString: String {
		switch daysTillBirthday {
		case let d where d > 365:
			return "More than a year away"
		case 335...365:
			return "About a year away"
		case 31...334:
			let months = daysTillBirthday / 30
			return "\(months) months away"
		case 29...30:
			return "Almost a month away"
		case 11...28:
			return "\(daysTillBirthday) days away"
		case 3...10:
			return "In \(daysTillBirthday) days"
		case 2:
			return "Day after tomorrow"
		case 1:
			return "Tomorrow"
		case 0:
			return "Today"
		default:
			return "Passed or invalid date"
		}
	}

}
