import UIKit

/// Phone-first navigation coordinator with exactly one navigation stack.
/// This deliberately does not create a split view or side-by-side detail column.
@MainActor
final class SingleStackCoordinator {
    let navigationController: UINavigationController

    init(rootViewController: UIViewController) {
        navigationController = UINavigationController(rootViewController: rootViewController)
    }

    func show(_ viewController: UIViewController, animated: Bool = true) {
        navigationController.pushViewController(viewController, animated: animated)
    }

    func closeCurrent(animated: Bool = true) {
        guard navigationController.viewControllers.count > 1 else { return }
        navigationController.popViewController(animated: animated)
    }

    func returnToRoot(animated: Bool = true) {
        navigationController.popToRootViewController(animated: animated)
    }
}
