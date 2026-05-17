import SwiftUI
import FamilyControls

struct AppSelectionView: View {
    @EnvironmentObject private var shieldManager: ShieldManager

    @State private var selection = FamilyActivitySelection()
    @State private var isPickerPresented = false

    var body: some View {
        NavigationStack {
            ZStack {
                NightGradientBackground()

                VStack(spacing: 18) {
                    VStack(spacing: 12) {
                        Image(systemName: "app.badge.checkmark")
                            .font(.system(size: 48))

                        Text("対象アプリを選択")
                            .font(.title2.bold())

                        Text("YouTube / TikTok / Netflix / Safari / SNS などを選択")
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.white.opacity(0.72))

                        Text("選択済みアプリ: \(selection.applicationTokens.count)個")
                            .font(.headline)
                    }
                    .padding()
                    .glassCard()

                    Button {
                        isPickerPresented = true
                    } label: {
                        Text("アプリを選択・再編集")
                            .frame(maxWidth: .infinity)
                            .padding()
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.purple)

                    Spacer()
                }
                .padding()
            }
            .navigationTitle("Apps")
            .onAppear {
                selection = shieldManager.selection
            }
            .familyActivityPicker(isPresented: $isPickerPresented, selection: $selection)
            .onChange(of: selection) { _, newValue in
                shieldManager.selection = newValue
            }
        }
    }
}
