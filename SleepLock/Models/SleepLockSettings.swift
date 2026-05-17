import Foundation
import FamilyControls

struct SleepLockSettings: Codable, Equatable {
    var startHour: Int = 23
    var startMinute: Int = 30
    var endHour: Int = 7
    var endMinute: Int = 0
    var repeatsDaily: Bool = true
    var lowPowerGuardEnabled: Bool = true
    var lowPowerThresholdPercent: Int = 10

    static let defaults = SleepLockSettings()
}

enum SleepLockStatus: String {
    case notConfigured = "未設定"
    case waiting = "待機中"
    case locked = "ロック中"
}
