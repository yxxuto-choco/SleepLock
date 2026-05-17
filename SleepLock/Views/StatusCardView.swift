import SwiftUI

struct StatusCardView: View {
    @EnvironmentObject private var shieldManager: ShieldManager
    @EnvironmentObject private var authorizationManager: AuthorizationManager
    @EnvironmentObject private var deviceActivityManager: DeviceActivityManager

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack {
                Text(shieldManager.isShielding ? "ロック中" : "待機中")
                    .font(.system(size: 32, weight: .bold, design: .rounded))

                Spacer()

                Image(systemName: shieldManager.isShielding ? "lock.fill" : "moon.zzz.fill")
                    .font(.largeTitle)
            }

            Divider().background(.white.opacity(0.3))

            InfoLine(title: "今日のロック時間", value: deviceActivityManager.nextScheduleText)
            InfoLine(title: "Shield理由", value: shieldManager.lastReason)
            InfoLine(title: "FamilyControls", value: authorizationManager.familyControlsStatusText)
        }
        .padding(20)
        .glassCard()
    }
}

private struct InfoLine: View {
    let title: String
    let value: String

    var body: some View {
        HStack(alignment: .top) {
            Text(title).foregroundStyle(.white.opacity(0.7))
            Spacer()
            Text(value).multilineTextAlignment(.trailing)
        }
        .font(.subheadline)
    }
}
