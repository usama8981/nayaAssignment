//
//  ShoppingItemLocal+CoreDataProperties.swift
//  NayaAssignment
//
//  Created by Usama Ali on 03/04/2022.
//
//

import Foundation
import CoreData


extension ShoppingItemLocal {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ShoppingItemLocal> {
        return NSFetchRequest<ShoppingItemLocal>(entityName: "ShoppingItemLocal")
    }

    @NSManaged public var id: String?
    @NSManaged public var sku: String?
    @NSManaged public var image: String?
    @NSManaged public var brand: String?
    @NSManaged public var name: String?
    @NSManaged public var price: Int64
    @NSManaged public var orignalPrice: Int64
    @NSManaged public var badges: [String]?
    @NSManaged public var isAddedToWishList: Bool
    @NSManaged public var isAddedToBag: Bool

}

extension ShoppingItemLocal : Identifiable {

}
