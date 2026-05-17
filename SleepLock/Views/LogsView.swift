import SwiftUI

struct LogsView: View {
    @EnvironmentObject private var logManager: LogManager

    private let formatter: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return f
    }()

    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()

                List {
                    ForEach(logManager.logs) { log in
                        VStack(alignment: .leading, spacing: 4) {
                            Text(formatter.string(from: log.date))
                                .font(.caption.monospaced())
                                .foregroundStyle(.green.opacity(0.75))

                            Text(log.message)
                                .font(.system(.footnote, design: .monospaced))
                                .foregroundStyle(.white)
                        }
                        .listRowBackground(Color.black)
                    }
                }
                .scrollContentBackground(.hidden)
            }
            .navigationTitle("Logs")
            .toolbar {
                Button("Clear") {
                    logManager.clear()
                }
            }
        }
    }
}
