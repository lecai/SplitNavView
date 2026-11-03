import UIKit

/// Minimal split controller that leaves column collapse and expansion to UIKit.
/// Each column owns its own navigation stack; this type never moves VCs between stacks.
@MainActor
final class NativeSplitViewController: UISplitViewController {
    private let primaryNavigationController: UINavigationController

    init(primary: UIViewController, initialDetail: UIViewController) {
        primaryNavigationController = UINavigationController(rootViewController: primary)
        super.init(style: .doubleColumn)

        preferredDisplayMode = .oneBesideSecondary
        presentsWithGesture = false
        setViewController(primaryNavigationController, for: .primary)
        setViewController(UINavigationController(rootViewController: initialDetail), for: .secondary)
    }

    required init?(coder: NSCoder) {
        fatalError("Use init(primary:initialDetail:) to create NativeSplitViewController")
    }

    /// Replaces the detail column through the split view's public API.
    /// UIKit decides how this is presented when the split is collapsed.
    func showDetail(_ viewController: UIViewController, animated: Bool = true) {
        showDetailViewController(viewController, sender: self)
    }

    /// Pushes within the primary column without involving the detail column.
    func pushPrimary(_ viewController: UIViewController, animated: Bool = true) {
        primaryNavigationController.pushViewController(viewController, animated: animated)
    }
}
