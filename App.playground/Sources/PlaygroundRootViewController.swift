import UIKit
import Then

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
    preferredContentSize = size
  }
  required init(coder aDecoder: NSCoder) { fatalError() }
  public override func viewDidLoad() {
    super.viewDidLoad()
    view.frame = CGRect(origin: .zero, size: size)
    addChild(viewController)
    view.addSubview(viewController.view.then {
      $0.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    })
    viewController.didMove(toParent: self)
  }
}
