import SwiftUI

struct OnboardingView: View {
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = false
    @EnvironmentObject private var authorizationManager: AuthorizationManager

    var body: some View {
        ZStack {
            NightGradientBackground()

            VStack(spacing: 24) {
                Spacer()

                VStack(spacing: 14) {
                    Image(systemName: "moon.stars.fill")
                        .font(.system(size: 64))
                        .foregroundStyle(.white)

                    Text("SleepLock")
                        .font(.system(size: 42, weight: .bold, design: .rounded))

                    Text("寝落ち再生から、朝のアラームを守る。")
                        .foregroundStyle(.white.opacity(0.82))
                }

                VStack(alignment: .leading, spacing: 16) {
                    Text("• iOSのScreen Time Shieldを利用")
                    Text("• 強制終了ではなく利用制限")
                    Text("• 夜間に自動ロック")
                    Text("• 低電力ガード搭載")
                }
                .padding(22)
                .glassCard()

                Button {
                    Task {
                        await authorizationManager.requestAll()
                        hasCompletedOnboarding = true
                    }
                } label: {
                    Text("権限を許可して始める")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.white)
                        .foregroundStyle(.indigo)
                        .clipShape(RoundedRectangle(cornerRadius: 18))
                }

                Spacer()
            }
            .padding(24)
            .foregroundStyle(.white)
        }
    }
}
