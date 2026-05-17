import SwiftUI

struct ContentView: View {
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = false

    var body: some View {
        Group {
            if hasCompletedOnboarding {
                MainTabView()
            } else {
                OnboardingView()
            }
        }
    }
}

private struct MainTabView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem { Label("Home", systemImage: "moon.zzz.fill") }

            AppSelectionView()
                .tabItem { Label("Apps", systemImage: "app.badge.checkmark") }

            ScheduleSettingsView()
                .tabItem { Label("Schedule", systemImage: "clock.fill") }

            LogsView()
                .tabItem { Label("Logs", systemImage: "terminal.fill") }
        }
        .preferredColorScheme(.dark)
    }
}
