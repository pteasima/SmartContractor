//
//  Navigation.swift
//  SmartContractorFramework
//
//  Created by Petr Šíma on 16/08/2018.
//

import UIKit
import Then
import Unidirectional

public protocol AppDelegateProtocol: UIApplicationDelegate {
  var window: UIWindow? { get set }
}

extension NSUserActivity {
  func createViewController() -> UIViewController {
    let vc: UIViewController
    switch webpageURL {
    case let url? where url.absoluteString.contains("/support"):
      vc = R.storyboard.support.support()!
    default: vc = R.storyboard.support.support()!
    }
    vc.userActivity = self
    return vc
  }
}

public protocol NavigationEffect: Effect {
  static func dismiss(to: NSUserActivity, andPresent: NSUserActivity?, animated: Bool, completion: @escaping () -> Action) -> Self
}
private var currentViewController: UIViewController? = (UIApplication.shared.keyWindow!.rootViewController as! UINavigationController).topViewController
extension RunEffect: NavigationEffect {
  public static func dismiss(to: NSUserActivity, andPresent: NSUserActivity?, animated: Bool, completion: @escaping () -> Action) -> RunEffect<Action> {
    return .init { callback in
      func makeRootInNewWindow() {
        (UIApplication.shared.delegate as? AppDelegateProtocol)?.window = UIWindow(frame: UIScreen.main.bounds).then {
          $0.rootViewController = to.createViewController()
          $0.makeKeyAndVisible()
        }
      }

      guard let presenter = currentViewController?.target(forAction: #selector(UIViewController.dismiss(to:andPresent:animated:completion:)), withSender: to) as? UIViewController else {
        makeRootInNewWindow()
        return
      }
      currentViewController = presenter.dismiss(to: to, andPresent: andPresent, animated: animated) { callback(completion()) }
    }


  }
}
extension UIViewController {
  open override func target(forAction action: Selector, withSender sender: Any?) -> Any? {
   return super.target(forAction: action, withSender: sender)
  }

  @objc fileprivate func dismiss(to: NSUserActivity, andPresent: NSUserActivity?, animated: Bool, completion: @escaping () -> Void) -> UIViewController? {
    assert(to == userActivity)
    //dismiss to self
    navigationController?.dismiss(animated: animated, completion: nil)
    navigationController?.popViewController(animated: animated)

    if let presented = andPresent?.createViewController()  {
      present(presented, animated: animated, completion: completion)
      return presented
    } else {
      completion()
      return self
    }
  }

  open override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
    switch action {
    case #selector(dismiss(to:andPresent:animated:completion:)):
      guard let to = sender as? NSUserActivity else {
        assertionFailure(); return false
      }
      return to == userActivity
    default:
      return super.canPerformAction(action, withSender: sender)
    }

  }
}

extension UINavigationController {
  override func dismiss(to: NSUserActivity, andPresent: NSUserActivity?, animated: Bool, completion: @escaping () -> Void) -> UIViewController? {
    if let child = childThatCanPerform(#selector(dismiss(to:andPresent:animated:completion:)), withSender: to) {
      popToViewController(child, animated: animated)
      return child.dismiss(to: to, andPresent: andPresent, animated: animated, completion: completion)
    }
    return super.dismiss(to: to, andPresent: andPresent, animated: animated, completion: completion)
  }
  open override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
    return childThatCanPerform(action, withSender: sender) != nil || super.canPerformAction(action, withSender: sender)
  }


  func childThatCanPerform(_ action: Selector, withSender sender: Any?) -> UIViewController? {
    return viewControllers.first (where: { $0.canPerformAction(action, withSender: sender) })
  }
}
