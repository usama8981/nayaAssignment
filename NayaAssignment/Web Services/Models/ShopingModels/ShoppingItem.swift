//
//  Items.swift
//  NayaAssignment
//
//  Created by Usama Ali on 02/04/2022.
//

import Foundation
struct ShoppingItem : Codable {
	let id : String?
	let sku : String?
	let image : String?
	let brand : String?
	let name : String?
	let price : Int?
	let originalPrice : Int?
	let badges : [String]?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case sku = "sku"
		case image = "image"
		case brand = "brand"
		case name = "name"
		case price = "price"
		case originalPrice = "originalPrice"
		case badges = "badges"
	}

}
