import Foundation
import FamilyControls
import ManagedSettings

@MainActor
final class ShieldManager: ObservableObject {
    static let shared = ShieldManager()

    @Published private(set) var isShielding = false
    @Published private(set) var lastReason = "none"

    private let store = ManagedSettingsStore(named: ManagedSettingsStore.Name(AppConstants.managedSettingsStoreName))
    private let defaults = UserDefaults(suiteName: AppConstants.defaultsSuiteName) ?? .standard
    private let selectionKey = "familyActivitySelection"

    private init() {
        isShielding = defaults.bool(forKey: "isShielding")
        lastReason = defaults.string(forKey: "lastShieldReason") ?? "none"
    }

    var selection: FamilyActivitySelection {
        get {
            guard let data = defaults.data(forKey: selectionKey),
                  let decoded = try? JSONDecoder().decode(FamilyActivitySelection.self, from: data) else {
                return FamilyActivitySelection()
            }
            return decoded
        }
        set {
            let data = try? JSONEncoder().encode(newValue)
            defaults.set(data, forKey: selectionKey)
            LogManager.shared.add("Selected apps updated. appTokens=\(newValue.applicationTokens.count)")
        }
    }

    var selectedAppCount: Int {
        selection.applicationTokens.count
    }

    func applyShield(reason: String = "manual") {
        let selected = selection

        store.shield.applications = selected.applicationTokens.isEmpty ? nil : selected.applicationTokens

        isShielding = true
        lastReason = reason

        defaults.set(true, forKey: "isShielding")
        defaults.set(reason, forKey: "lastShieldReason")

        LogManager.shared.add("Shield applied. reason=\(reason)")
    }

    func clearShield(reason: String = "manual") {
        store.clearAllSettings()

        isShielding = false
        lastReason = reason

        defaults.set(false, forKey: "isShielding")
        defaults.set(reason, forKey: "lastShieldReason")

        LogManager.shared.add("Shield cleared. reason=\(reason)")
    }

    nonisolated static func applyShieldFromExtension(reason: String) {
        let defaults = UserDefaults(suiteName: AppConstants.defaultsSuiteName) ?? .standard

        guard let data = defaults.data(forKey: "familyActivitySelection"),
              let selection = try? JSONDecoder().decode(FamilyActivitySelection.self, from: data) else {
            LogManager.addFromExtension("Extension failed to decode FamilyActivitySelection")
            return
        }

        let store = ManagedSettingsStore(named: ManagedSettingsStore.Name(AppConstants.managedSettingsStoreName))
        store.shield.applications = selection.applicationTokens

        defaults.set(true, forKey: "isShielding")
        defaults.set(reason, forKey: "lastShieldReason")

        LogManager.addFromExtension("Extension applied Shield. reason=\(reason)")
    }

    nonisolated static func clearShieldFromExtension(reason: String) {
        let defaults = UserDefaults(suiteName: AppConstants.defaultsSuiteName) ?? .standard

        let store = ManagedSettingsStore(named: ManagedSettingsStore.Name(AppConstants.managedSettingsStoreName))
        store.clearAllSettings()

        defaults.set(false, forKey: "isShielding")
        defaults.set(reason, forKey: "lastShieldReason")

        LogManager.addFromExtension("Extension cleared Shield. reason=\(reason)")
    }
}
