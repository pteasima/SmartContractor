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
  static func dismiss(to: NSUserActivity, andPresent: [NSUserActivity]) -> Self
}
private var currentViewController: UIViewController? = (UIApplication.shared.keyWindow!.rootViewController as! UINavigationController).topViewController
extension RunEffect: NavigationEffect {
  public static func dismiss(to: NSUserActivity, andPresent: [NSUserActivity]) -> RunEffect<Action> {
    return .init { _ in

      func makeRootInNewWindow() {
        (UIApplication.shared.delegate as? AppDelegateProtocol)?.window = UIWindow(frame: UIScreen.main.bounds).then {
          $0.rootViewController = to.createViewController()
          $0.makeKeyAndVisible()
        }
      }

      guard let presenter = currentViewController?.target(forAction: #selector(UIViewController.present(activities:from:)), withSender: to) as? UIViewController else {
        makeRootInNewWindow()
        return
      }
      currentViewController = presenter.present(activities: andPresent, from: to)
    }


  }
}
extension UIViewController {
  open override func target(forAction action: Selector, withSender sender: Any?) -> Any? {
   return super.target(forAction: action, withSender: sender)
  }

  @objc fileprivate  func present(activities: [NSUserActivity], from: NSUserActivity) -> UIViewController {
    assert(from == userActivity)
    //dismiss to self
    navigationController?.dismiss(animated: true, completion: nil)
    navigationController?.popViewController(animated: true)

    guard var presented = activities.last?.createViewController() else {
      return self //we we've just dismissing
    }
    let topmost = presented
    var intermediateActivities = activities.dropLast()
    while let presenter = intermediateActivities.last?.createViewController() {
      intermediateActivities.removeLast()
      presenter.present(presented, animated: false)
      presented = presenter
    }
    self.present(presented, animated: true, completion: nil)
    return topmost
  }

  open override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
    switch action {
    case #selector(present(activities:from:)):
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
  override func present(activities: [NSUserActivity], from: NSUserActivity) -> UIViewController {
    if let child = childThatCanPerform(#selector(present(activities:from:)), withSender: from) {
      popToViewController(child, animated: true)
      return child.present(activities: activities, from: from)
    }
    return super.present(activities: activities, from: from)
  }
  open override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
    return childThatCanPerform(action, withSender: sender) != nil || super.canPerformAction(action, withSender: sender)
  }


  func childThatCanPerform(_ action: Selector, withSender sender: Any?) -> UIViewController? {
    return viewControllers.first (where: { $0.canPerformAction(action, withSender: sender) })
  }
}
