import UIKit
import PlaygroundSupport
import SmartContractorFramework


let vc = UIStoryboard(name: "Contract", bundle: Bundle(for: ContractViewController.self)).instantiateInitialViewController()!
PlaygroundPage.current.liveView = PlaygroundRootViewController(
  viewController: vc,
  size: CGSize(width: 100, height: 2000)
//  size: .iphoneX
)

