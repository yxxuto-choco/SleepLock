import Foundation
import UIKit
import Combine

@MainActor
final class BatteryGuardManager: ObservableObject {
    static let shared = BatteryGuardManager()

    @Published private(set) var batteryPercent: Int = -1
    @Published private(set) var isBatteryGuardShieldActive = false

    @Published var isEnabled: Bool = true
    @Published var thresholdPercent: Int = 10

    let thresholdOptions = [10, 15, 20]

    private var cancellables = Set<AnyCancellable>()

    private init() {}

    func start() {
        UIDevice.current.isBatteryMonitoringEnabled = true

        updateBatteryLevel(source: "start")

        NotificationCenter.default.publisher(for: UIDevice.batteryLevelDidChangeNotification)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                Task { @MainActor in
                    self?.updateBatteryLevel(source: "notification")
                }
            }
            .store(in: &cancellables)

        LogManager.shared.add("BatteryGuard started")
    }

    private func updateBatteryLevel(source: String) {
        let raw = UIDevice.current.batteryLevel

        guard raw >= 0 else {
            batteryPercent = -1
            return
        }

        let percent = Int((raw * 100).rounded())
        batteryPercent = percent

        guard isEnabled else { return }

        if percent <= thresholdPercent {
            if !isBatteryGuardShieldActive {
                isBatteryGuardShieldActive = true
                ShieldManager.shared.applyShield(reason: "battery_guard")
                LogManager.shared.add("BatteryGuard triggered at \(percent)%")
            }
        } else if percent > max(thresholdPercent + 5, 15) {
            if isBatteryGuardShieldActive {
                isBatteryGuardShieldActive = false
                ShieldManager.shared.clearShield(reason: "battery_guard_recovered")
                LogManager.shared.add("BatteryGuard recovered at \(percent)%")
            }
        }
    }
}
