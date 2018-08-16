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
private var currentViewController: UIViewController? = UIApplication.shared.keyWindow!.rootViewController
extension RunEffect: NavigationEffect {
  public static func dismiss(to: NSUserActivity, andPresent: [NSUserActivity]) -> RunEffect<Action> {
    return .init { _ in

      func makeRootInNewWindow() {
        (UIApplication.shared.delegate as? AppDelegateProtocol)?.window = UIWindow(frame: UIScreen.main.bounds).then {
          $0.rootViewController = to.createViewController()
          $0.makeKeyAndVisible()
        }
      }

      guard let presenter = currentViewController?.target(forAction: #selector(UIViewController.present(activities:)), withSender: to) as? UIViewController else {
        makeRootInNewWindow()
        return
      }
      currentViewController = presenter.present(activities: andPresent)
    }


  }
}
extension UIViewController {
  @objc fileprivate  func present(activities: [NSUserActivity]) -> UIViewController {
    //dismiss to self
    navigationController?.dismiss(animated: false, completion: nil)
    navigationController?.popViewController(animated: false)


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
    case #selector(present(activities:)):
      guard let to = sender as? NSUserActivity else {
        assertionFailure(); return false
      }
      return to == userActivity
    default:
      return super.canPerformAction(action, withSender: sender)
    }

  }
}
