//
//  ShopingModel.swift
//  NayaAssignment
//
//  Created by Usama Ali on 02/04/2022.
//

import Foundation
struct ShoppingResponse : Codable {
	let title : String?
	let currency : String?
	let items : [ShoppingItem]?

	enum CodingKeys: String, CodingKey {

		case title = "title"
		case currency = "currency"
		case items = "items"
	}
}
