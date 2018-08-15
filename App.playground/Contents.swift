import UIKit
import PlaygroundSupport
import SmartContractorFramework


let vc = (UIStoryboard(name: "Contract", bundle: Bundle(for: ContractViewController.self)).instantiateInitialViewController() as! ContractViewController).onViewDidLoad {
    print($0)
  }
PlaygroundPage.current.liveView = PlaygroundRootViewController(
  viewController: vc,
  size: .iphoneX
)

