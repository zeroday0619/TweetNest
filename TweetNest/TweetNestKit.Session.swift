//
//  TweetNestKit.Session.swift
//  TweetNest
//
//  Created by Jaehong Kang on 2021/02/23.
//

import Foundation
import TweetNestKit

extension TweetNestKit.Session {
    public static var preview: Session = {
        let result = Session(inMemory: true)
        let viewContext = result.container.viewContext
        for _ in 0..<3 {
            let newAccount = Account(context: viewContext)
            newAccount.id = Int64.random(in: Int64.min...Int64.max)
            newAccount.addedAt = Date()
        }
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()
}
