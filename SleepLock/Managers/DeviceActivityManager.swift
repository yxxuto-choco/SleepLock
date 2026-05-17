import Foundation
import DeviceActivity
import SwiftUI

@MainActor
final class DeviceActivityManager: ObservableObject {
    static let shared = DeviceActivityManager()

    @Published private(set) var nextScheduleText = "未設定"

    private let center = DeviceActivityCenter()
    private let defaults = UserDefaults(suiteName: AppConstants.defaultsSuiteName) ?? .standard

    private init() {}

    func startMonitoring(settings: SleepLockSettings) {
        var start = DateComponents()
        start.hour = settings.startHour
        start.minute = settings.startMinute

        var end = DateComponents()
        end.hour = settings.endHour
        end.minute = settings.endMinute

        let schedule = DeviceActivitySchedule(
            intervalStart: start,
            intervalEnd: end,
            repeats: settings.repeatsDaily
        )

        do {
            try center.startMonitoring(DeviceActivityName(AppConstants.deviceActivityName), during: schedule)

            nextScheduleText = String(format: "%02d:%02d〜%02d:%02d", settings.startHour, settings.startMinute, settings.endHour, settings.endMinute)

            defaults.set(nextScheduleText, forKey: "nextScheduleText")

            LogManager.shared.add("DeviceActivity monitoring started: \(nextScheduleText)")
        } catch {
            LogManager.shared.add("DeviceActivity monitoring failed: \(error.localizedDescription)")
        }
    }

    func stopMonitoring() {
        center.stopMonitoring([DeviceActivityName(AppConstants.deviceActivityName)])
        nextScheduleText = "停止中"
        defaults.set(nextScheduleText, forKey: "nextScheduleText")

        LogManager.shared.add("DeviceActivity monitoring stopped")
    }
}
