import Foundation
import FamilyControls
import UserNotifications

@MainActor
final class AuthorizationManager: ObservableObject {
    static let shared = AuthorizationManager()

    @Published private(set) var familyControlsStatusText = "未確認"
    @Published private(set) var notificationStatusText = "未確認"

    private init() {}

    func requestAll() async {
        do {
            try await AuthorizationCenter.shared.requestAuthorization(for: .individual)
            familyControlsStatusText = "FamilyControls: authorized"
            LogManager.shared.add("Authorization granted: FamilyControls")
        } catch {
            familyControlsStatusText = "FamilyControls: failed"
            LogManager.shared.add("Authorization failed: \(error.localizedDescription)")
        }

        do {
            let granted = try await UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge])
            notificationStatusText = granted ? "Notifications: authorized" : "Notifications: denied"
            LogManager.shared.add("Notification authorization: \(granted)")
        } catch {
            notificationStatusText = "Notifications: failed"
            LogManager.shared.add("Notification authorization failed: \(error.localizedDescription)")
        }
    }

    func refreshStatus() {
        let status = AuthorizationCenter.shared.authorizationStatus
        familyControlsStatusText = "FamilyControls: \(String(describing: status))"

        UNUserNotificationCenter.current().getNotificationSettings { settings in
            Task { @MainActor in
                self.notificationStatusText = "Notifications: \(String(describing: settings.authorizationStatus))"
            }
        }

        LogManager.shared.add("Authorization status refreshed: \(familyControlsStatusText)")
    }
}
