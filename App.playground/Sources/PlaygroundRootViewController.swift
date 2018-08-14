import UIKit

public extension CGSize {
  static var iphoneX: CGSize { return CGSize(width: 375, height: 812) }
}

public final class PlaygroundRootViewController: UIViewController {
  private let viewController: UIViewController
  private var size: CGSize
  public init(viewController: UIViewController, size: CGSize) {
    self.viewController = viewController
    self.size = size
    super.init(nibName: nil, bundle: nil)
  }
  required init(coder aDecoder: NSCoder) { fatalError() }
  public override func viewDidLoad() {
    super.viewDidLoad()
    view.frame = CGRect(origin: .zero, size: size)
    addChild(viewController)
    view.addSubview(viewController.view)
    viewController.view.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      viewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      viewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      viewController.view.topAnchor.constraint(equalTo: view.topAnchor),
      viewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      ])
    viewController.didMove(toParent: self)
  }
}
