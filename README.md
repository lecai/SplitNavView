# Split navigation experiments

This repository compares adaptive native split navigation with a single-stack alternative.

## Adaptive split (recommended for dual-screen/foldable and regular phones)

`Sources/NativeSplit/NativeSplitViewController.swift` uses a `.doubleColumn` `UISplitViewController` with one navigation controller per column. It sets `.automatic` display mode and lets UIKit adapt to the available window size:

- A narrow phone window uses the collapsed presentation.
- A wide/unfolded device or sufficiently wide app window can display both columns.
- On iPad, Stage Manager and system multitasking change the app window size; UIKit adapts the app's internal columns without controlling system multitasking.

The implementation intentionally has no custom collapse/expand delegate, trait override, VC stack migration, transition snapshots, or deferred navigation queue. Use `showDetail(_:animated:)` for presenting a selected detail so UIKit can adapt it to the current layout. Use `pushDetail` only for navigation within the already existing secondary stack.

The split adapts to available width, not a hard-coded model name. Test on the minimum supported iOS version and on actual narrow/wide window sizes. `UISplitViewController`'s `isCollapsed` is the authoritative current state.

## Single-stack fallback

`Sources/SingleStack/SingleStackCoordinator.swift` demonstrates one `UINavigationController` stack. It is the simplest option when the interface should always have one back stack and never needs simultaneous side-by-side columns.

## Integration

These are standalone starting points, not a drop-in replacement for `ZMUISplitViewController`: that source depends on project-specific protocols, `ZMNavigationController`, and `iOSAdditions`, which are not present in this repository. Add the source to an iOS app target, connect real screen controllers, and run the supported iOS/device matrix before shipping.
