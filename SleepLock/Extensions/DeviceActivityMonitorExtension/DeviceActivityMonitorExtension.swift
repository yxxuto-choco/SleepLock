import DeviceActivity
import Foundation
import ManagedSettings
import FamilyControls

/*
 Extension setup:
 - Xcode > File > New > Target > Device Activity Monitor Extension
 - Add Family Controls capability to this extension target.
 - Add App Groups capability to this extension target.
 - Use the same App Group as the main app.
 - This extension is responsible for DeviceActivity callbacks.
*/

final class DeviceActivityMonitorExtension: DeviceActivityMonitor {
    override func intervalDidStart(for activity: DeviceActivityName) {
        super.intervalDidStart(for: activity)

        guard activity.rawValue == AppConstants.deviceActivityName else { return }

        LogManager.addFromExtension("DeviceActivity intervalDidStart callback")
        ShieldManager.applyShieldFromExtension(reason: "device_activity_interval_start")
    }

    override func intervalDidEnd(for activity: DeviceActivityName) {
        super.intervalDidEnd(for: activity)

        guard activity.rawValue == AppConstants.deviceActivityName else { return }

        LogManager.addFromExtension("DeviceActivity intervalDidEnd callback")
        ShieldManager.clearShieldFromExtension(reason: "device_activity_interval_end")
    }
}
