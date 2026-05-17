import Foundation
import SwiftUI

@MainActor
final class LogManager: ObservableObject {
    static let shared = LogManager()

    @Published private(set) var logs: [LogEntry] = []

    private let key = "sleepLockLogs"
    private let defaults = UserDefaults(suiteName: AppConstants.defaultsSuiteName) ?? .standard
    private let maxLogs = 200

    private init() {
        load()
    }

    func add(_ message: String) {
        let entry = LogEntry(message: message)
        logs.insert(entry, at: 0)
        logs = Array(logs.prefix(maxLogs))
        save()
        print("[SleepLock] \(message)")
    }

    func clear() {
        logs.removeAll()
        save()
    }

    private func load() {
        guard let data = defaults.data(forKey: key) else { return }
        logs = (try? JSONDecoder().decode([LogEntry].self, from: data)) ?? []
    }

    private func save() {
        let data = try? JSONEncoder().encode(logs)
        defaults.set(data, forKey: key)
    }

    nonisolated static func addFromExtension(_ message: String) {
        let defaults = UserDefaults(suiteName: AppConstants.defaultsSuiteName) ?? .standard
        let key = "sleepLockLogs"
        var current: [LogEntry] = []

        if let data = defaults.data(forKey: key),
           let decoded = try? JSONDecoder().decode([LogEntry].self, from: data) {
            current = decoded
        }

        current.insert(LogEntry(message: message), at: 0)
        current = Array(current.prefix(200))

        let data = try? JSONEncoder().encode(current)
        defaults.set(data, forKey: key)
    }
}
