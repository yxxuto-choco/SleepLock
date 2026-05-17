import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var shieldManager: ShieldManager
    @EnvironmentObject private var batteryGuardManager: BatteryGuardManager

    var body: some View {
        NavigationStack {
            ZStack {
                NightGradientBackground()

                ScrollView {
                    VStack(spacing: 18) {
                        StatusCardView()

                        VStack(spacing: 12) {
                            HStack {
                                Label("対象アプリ", systemImage: "app.badge.checkmark")
                                Spacer()
                                Text("\(shieldManager.selectedAppCount)個")
                            }

                            HStack {
                                Label("バッテリー", systemImage: "battery.25")
                                Spacer()
                                Text(batteryGuardManager.batteryPercent < 0 ? "取得不可" : "\(batteryGuardManager.batteryPercent)%")
                            }
                        }
                        .padding()
                        .glassCard()

                        VStack(spacing: 12) {
                            Button {
                                shieldManager.applyShield(reason: "manual_now")
                            } label: {
                                Label("今すぐShield ON", systemImage: "shield.fill")
                                    .frame(maxWidth: .infinity)
                                    .padding()
                            }
                            .buttonStyle(.borderedProminent)

                            Button {
                                shieldManager.clearShield(reason: "manual_clear")
                            } label: {
                                Label("Shield解除", systemImage: "shield.slash.fill")
                                    .frame(maxWidth: .infinity)
                                    .padding()
                            }
                            .buttonStyle(.bordered)
                        }
                        .tint(.purple)
                    }
                    .padding()
                }
            }
            .navigationTitle("SleepLock")
        }
    }
}
