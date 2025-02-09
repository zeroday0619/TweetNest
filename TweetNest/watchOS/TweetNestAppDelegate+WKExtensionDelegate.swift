//
//  TweetNestAppDelegate.swift
//  TweetNestAppDelegate
//
//  Created by Jaehong Kang on 2021/08/25.
//

import WatchKit
import UserNotifications

extension TweetNestAppDelegate: WKExtensionDelegate {
    func applicationDidFinishLaunching() {
        UNUserNotificationCenter.current().delegate = self
    }

    func handle(_ backgroundTasks: Set<WKRefreshBackgroundTask>) {
        let handledBackgroundTasks = session.handleBackgroundRefreshBackgroundTask(backgroundTasks)

        for backgroundTask in backgroundTasks.subtracting(handledBackgroundTasks) {
            switch backgroundTask {
            case let backgroundTask as WKSnapshotRefreshBackgroundTask:
                DispatchQueue.main.async {
                    backgroundTask.setTaskCompleted(restoredDefaultState: false, estimatedSnapshotExpiration: .distantFuture, userInfo: nil)
                }
            default:
                break
            }
        }
    }
}
