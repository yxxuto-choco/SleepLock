# SleepLock Setup Guide

## 1. Project structure

```text
SleepLock/
  SleepLockApp.swift
  ContentView.swift
  Shared/AppConstants.swift
  Models/
    SleepLockSettings.swift
    LogEntry.swift
  Managers/
    AuthorizationManager.swift
    ShieldManager.swift
    DeviceActivityManager.swift
    LogManager.swift
    BatteryGuardManager.swift
  Views/
    HomeView.swift
    OnboardingView.swift
    AppSelectionView.swift
    ScheduleSettingsView.swift
    LogsView.swift
    StatusCardView.swift
    NightStyle.swift
  Extensions/
    DeviceActivityMonitorExtension/
      DeviceActivityMonitorExtension.swift
```

## 2. Xcode settings

Create a new SwiftUI iOS App project named `SleepLock`.

- Interface: SwiftUI
- Language: Swift
- Deployment target: iOS 17+
- Signing Team: your Apple Developer Program team

Add all app files to the main app target except the extension file.

## 3. Capability settings

Main app target:

- Family Controls
- App Groups: `group.com.example.SleepLock` or your own value

DeviceActivityMonitor extension target:

- Family Controls
- App Groups: same value as main app

Update `Shared/AppConstants.swift` to match your App Group.

## 4. Extension setup

Xcode:

- File > New > Target...
- Device Activity Monitor Extension
- Product Name: `SleepLockDeviceActivityMonitor`
- Add `DeviceActivityMonitorExtension.swift` to that extension target.

## 5. Code

All Swift code is included under `SleepLock/`.

## 6. Build

Build on a real iPhone.

The Simulator may not support Screen Time Shield behavior.

## 7. Real device validation

1. Run the app on iPhone.
2. Complete onboarding and FamilyControls authorization.
3. Select YouTube in the App picker.
4. Start YouTube playback.
5. Return to SleepLock and tap “今すぐShield ON”.
6. Confirm whether YouTube is blocked and playback stops.
7. Check the Logs tab.

## 8. Expected limitations

- iOS apps cannot force-quit other apps.
- Shielding is the correct Screen Time API mechanism.
- Battery guard is best-effort and only works while the app is running or iOS wakes it.
- Battery monitoring is not a guaranteed always-on background trigger.
- DeviceActivity callbacks require real entitlements and extension configuration.

## 9. App Store review notes

- Avoid saying “force quit YouTube.”
- Say “user-selected Screen Time Shield.”
- Clearly explain user consent and app selection.
- Low-power guard must be described as a supplemental best-effort guard.
