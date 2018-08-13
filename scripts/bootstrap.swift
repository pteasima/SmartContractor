import Foundation
import ShellOut

print(try shellOut(to: "xcodegen"))
print(try shellOut(to: .installCocoaPods()))
