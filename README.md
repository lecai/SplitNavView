# Split navigation experiments

This repository contains two small UIKit prototypes to compare against a custom split controller that manually moves view controllers between navigation stacks.

## Option 1 — Native split with independent navigation stacks

`Sources/NativeSplit/NativeSplitViewController.swift` keeps one `UINavigationController` in each column and leaves collapse/expand to UIKit. Do not copy the custom stack migration, snapshots, or deferred-operation machinery from the original implementation. Use `showDetailViewController(_:sender:)` to present or replace detail content.

This is the closest behavioral match to a two-column iPad interface. Verify the app's desired compact-mode back behavior on its minimum supported iOS version before adopting it.

## Option 2 — One navigation stack

`Sources/SingleStack/SingleStackCoordinator.swift` demonstrates a single `UINavigationController` stack. Detail pages are pushed onto that stack; it intentionally does not provide simultaneous side-by-side columns. This is the simpler choice when preserving one predictable back stack is more important than a two-column expanded layout.

## Integration

These are standalone starting points, not a drop-in replacement for `ZMUISplitViewController`: the original source depends on project-specific protocols, `ZMNavigationController`, and `iOSAdditions`, none of which are present in this newly created repository. Add the source to an iOS app target, connect real screen controllers, and run the project's supported-device/iOS test matrix before shipping.
