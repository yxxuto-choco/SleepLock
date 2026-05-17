import SwiftUI

struct ScheduleSettingsView: View {
    @EnvironmentObject private var deviceActivityManager: DeviceActivityManager
    @EnvironmentObject private var batteryGuardManager: BatteryGuardManager

    @AppStorage("startHour") private var startHour = 23
    @AppStorage("startMinute") private var startMinute = 30
    @AppStorage("endHour") private var endHour = 7
    @AppStorage("endMinute") private var endMinute = 0
    @AppStorage("repeatsDaily") private var repeatsDaily = true

    private var startDate: Binding<Date> {
        Binding(
            get: { makeDate(hour: startHour, minute: startMinute) },
            set: { date in
                let c = Calendar.current.dateComponents([.hour, .minute], from: date)
                startHour = c.hour ?? 23
                startMinute = c.minute ?? 30
            }
        )
    }

    private var endDate: Binding<Date> {
        Binding(
            get: { makeDate(hour: endHour, minute: endMinute) },
            set: { date in
                let c = Calendar.current.dateComponents([.hour, .minute], from: date)
                endHour = c.hour ?? 7
                endMinute = c.minute ?? 0
            }
        )
    }

    var body: some View {
        NavigationStack {
            ZStack {
                NightGradientBackground()

                Form {
                    Section("ロック時間") {
                        DatePicker("開始", selection: startDate, displayedComponents: .hourAndMinute)
                        DatePicker("終了", selection: endDate, displayedComponents: .hourAndMinute)
                        Toggle("毎日繰り返し", isOn: $repeatsDaily)
                    }

                    Section("低電力ガード") {
                        Toggle("低電力ガードON/OFF", isOn: $batteryGuardManager.isEnabled)

                        Picker("閾値", selection: $batteryGuardManager.thresholdPercent) {
                            ForEach(batteryGuardManager.thresholdOptions, id: \.self) { value in
                                Text("\(value)%").tag(value)
                            }
                        }
                    }

                    Section {
                        Button("スケジュール開始") {
                            let settings = SleepLockSettings(
                                startHour: startHour,
                                startMinute: startMinute,
                                endHour: endHour,
                                endMinute: endMinute,
                                repeatsDaily: repeatsDaily,
                                lowPowerGuardEnabled: batteryGuardManager.isEnabled,
                                lowPowerThresholdPercent: batteryGuardManager.thresholdPercent
                            )

                            deviceActivityManager.startMonitoring(settings: settings)
                        }

                        Button("スケジュール停止", role: .destructive) {
                            deviceActivityManager.stopMonitoring()
                        }
                    }
                }
                .scrollContentBackground(.hidden)
            }
            .navigationTitle("Schedule")
        }
    }

    private func makeDate(hour: Int, minute: Int) -> Date {
        Calendar.current.date(from: DateComponents(hour: hour, minute: minute)) ?? Date()
    }
}
