import Foundation

enum AppConstants {
    // TODO: Xcode Signing & Capabilities > App Groups と完全一致させること。
    // 例: group.com.yourname.SleepLock
    static let appGroupID = "group.com.example.SleepLock"

    static let defaultsSuiteName = appGroupID

    static let deviceActivityName = "sleepLockNightSchedule"
    static let managedSettingsStoreName = "sleepLockStore"
}
