//
//  AppDelegate.swift
//  SmartContractorIos
//
//  Created by Petr Šíma on 14/08/2018.
//

import UIKit
import SmartContractorFramework
import Then
import Closures
import Unidirectional

//func url(_ string: String) -> URL {
//  return URL(string: "https://smartcontractor.cz" + string)!
//}
//
//let browsingHome = NSUserActivity(activityType: "cz.smartcontractor.browsingHome")
//  .then {
//    $0.webpageURL = url("/home")
//}
//let browsingDetail = NSUserActivity(activityType: "cz.smartcontractor.browsingDetails")
//  .then {
//    $0.webpageURL = url("/contracts/1")
//}

@UIApplicationMain
class AppDelegate: UIResponder, AppDelegateProtocol {

  var window: UIWindow?

  func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([Any]?) -> Void) -> Bool {

    return true
  }

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.

    window = UIWindow(frame: UIScreen.main.bounds).then {
      let vc = R.storyboard.contracts.instantiateInitialViewController()!.then {
        ($0.topViewController as! ContractsViewController).configure(for: HomeScreen())
        $0.userActivity = store.state.activities.last!
      }
      $0.rootViewController = vc

      //      vc.tableView.addElements([], cell:)
      $0.makeKeyAndVisible()
    }
    return true
  }

  func applicationWillResignActive(_ application: UIApplication) {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
  }

  func applicationDidEnterBackground(_ application: UIApplication) {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
  }

  func applicationWillEnterForeground(_ application: UIApplication) {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
  }

  func applicationDidBecomeActive(_ application: UIApplication) {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
  }

  func applicationWillTerminate(_ application: UIApplication) {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
  }


}

