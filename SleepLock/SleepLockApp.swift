import SwiftUI
import FamilyControls

/*
 Required:
 - iOS 17+
 - Apple Developer Program
 - Family Controls capability
 - App Groups capability
 - Device Activity Monitor Extension target
 - Real iPhone recommended / required for meaningful Screen Time API validation
 - Simulator may not apply Shield correctly
*/

@main
struct SleepLockApp: App {
    @StateObject private var logManager = LogManager.shared
    @StateObject private var shieldManager = ShieldManager.shared
    @StateObject private var batteryGuardManager = BatteryGuardManager.shared
    @StateObject private var deviceActivityManager = DeviceActivityManager.shared
    @StateObject private var authorizationManager = AuthorizationManager.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(logManager)
                .environmentObject(shieldManager)
                .environmentObject(batteryGuardManager)
                .environmentObject(deviceActivityManager)
                .environmentObject(authorizationManager)
                .onAppear {
                    batteryGuardManager.start()
                    authorizationManager.refreshStatus()
                }
        }
    }
}
