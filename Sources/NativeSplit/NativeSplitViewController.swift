import UIKit

/// Adaptive master/detail split that leaves size-class and column migration decisions to UIKit.
/// The primary and secondary columns each own one navigation controller. This controller never
/// moves view controllers between those stacks in layout or transition callbacks.
@MainActor
final class NativeSplitViewController: UISplitViewController {
    private let primaryNavigationController: UINavigationController
    private let secondaryNavigationController: UINavigationController

    init(primary: UIViewController, initialDetail: UIViewController) {
        primaryNavigationController = UINavigationController(rootViewController: primary)
        secondaryNavigationController = UINavigationController(rootViewController: initialDetail)
        super.init(style: .doubleColumn)

        // Automatic lets UIKit adapt to the actual window width: narrow phone windows collapse,
        // while a wide/unfolded device or a sufficiently wide multitasking window can show both.
        preferredDisplayMode = .automatic
        preferredSplitBehavior = .tile
        presentsWithGesture = false
        setViewController(primaryNavigationController, for: .primary)
        setViewController(secondaryNavigationController, for: .secondary)
    }

    required init?(coder: NSCoder) {
        fatalError("Use init(primary:initialDetail:) to create NativeSplitViewController")
    }

    /// Show detail through UISplitViewController's adaptation path.
    /// UIKit displays it in the secondary column when there is room and adapts it when collapsed.
    func showDetail(_ viewController: UIViewController, animated: Bool = true) {
        // Use the split's presentation API rather than moving the controller between nav stacks.
        // The API has no animation parameter; UIKit chooses the transition for the current layout.
        showDetailViewController(viewController, sender: self)
    }

    /// Pushes within the primary column without involving the detail column.
    func pushPrimary(_ viewController: UIViewController, animated: Bool = true) {
        primaryNavigationController.pushViewController(viewController, animated: animated)
    }

    /// Pushes within the detail navigation stack. Prefer `showDetail(_:)` when presenting a
    /// newly selected detail from the primary column so UIKit can adapt it in compact layouts.
    func pushDetail(_ viewController: UIViewController, animated: Bool = true) {
        secondaryNavigationController.pushViewController(viewController, animated: animated)
    }

    /// Exposed for callers that need to make presentation decisions; this is UIKit's current
    /// collapse state, not a separately inferred width/device model.
    var isDetailCollapsed: Bool {
        isCollapsed
    }
}
