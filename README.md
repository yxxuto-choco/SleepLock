# SleepLock

iOS Screen Time Shield app MVP.

SleepLock is an iOS 17+ SwiftUI MVP that uses Apple's Screen Time APIs:

- FamilyControls
- ManagedSettings
- DeviceActivity
- UserNotifications
- SwiftUI

Purpose:
Prevent overnight battery drain caused by YouTube/TikTok/Netflix/Safari playback continuing while asleep.

Important:
This app does NOT force quit apps.
It uses Apple's official Screen Time Shield APIs.

## MVP validation

Main verification target:

> If Shield is applied while YouTube is playing, does viewing continuity actually stop?

## Included features

- Immediate Shield ON button
- Shield clear button
- DeviceActivity scheduled lock
- DeviceActivityMonitorExtension
- Battery guard
- Logs screen
- Status screen
- FamilyActivityPicker

## Required setup

- Apple Developer Program
- iOS 17+
- Family Controls capability
- App Groups capability
- Real iPhone

## Important limitation

Screen Time APIs often do not behave correctly in Simulator.
Real-device testing is required.

## Windows development

You can:
- edit Swift files on Windows
- use Cursor / VSCode
- use GitHub
- use ChatGPT/Codex for development

But you cannot fully build/sign/run this app on Windows.

Final build + entitlement setup + extension creation + iPhone install require Xcode on macOS.
