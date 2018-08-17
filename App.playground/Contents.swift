import UIKit
import PlaygroundSupport
import SmartContractorFramework

let id = store.state.contracts.first!.id.rawValue.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!
let activity = NSUserActivity(activityType: "cz.smartcontractor.browseContractDetail").then {
  $0.webpageURL = URL(string: "https://smartcontractor.cz/contracts/\(id)")
}
let vc = UINavigationController(rootViewController: R.storyboard.contracts.contractViewController()!.then {
  $0.userActivity = activity
  })
vc.preferredContentSize = .iphoneX

PlaygroundPage.current.liveView = vc

print("✅")
