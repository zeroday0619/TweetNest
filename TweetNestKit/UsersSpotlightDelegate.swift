//
//  UsersSpotlightDelegate.swift
//  UsersSpotlightDelegate
//
//  Created by Jaehong Kang on 2021/08/06.
//

#if canImport(CoreSpotlight)

import CoreData
import CoreSpotlight

class UsersSpotlightDelegate: NSCoreDataCoreSpotlightDelegate {
    override func domainIdentifier() -> String {
        "\(Bundle.module.bundleIdentifier!).users"
    }

    override func indexName() -> String? {
        "users-index"
    }

    override func attributeSet(for object: NSManagedObject) -> CSSearchableItemAttributeSet? {
        if let user = object as? User {
            let attributeSet = CSSearchableItemAttributeSet(contentType: .contact)

            let sortedUserDetails = user.sortedUserDetails

            attributeSet.identifier = user.id
            attributeSet.displayName = sortedUserDetails?.last?.name
            attributeSet.alternateNames = sortedUserDetails?.last?.username.flatMap { ["@\($0)"] }
            attributeSet.thumbnailData = try? sortedUserDetails?.last?.profileImageURL.flatMap {
                let fetchRequest = DataAsset.fetchRequest()
                fetchRequest.predicate = NSPredicate(format: "url == %@", $0 as NSURL)
                fetchRequest.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
                fetchRequest.fetchLimit = 1

                return try user.managedObjectContext?.fetch(fetchRequest).first?.data
            }
            attributeSet.keywords = (sortedUserDetails?.compactMap(\.name) ?? []) + (sortedUserDetails?.compactMap(\.username) ?? [])

            return attributeSet
        }

        return nil
    }
}

#endif
