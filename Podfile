source 'https://github.com/CocoaPods/Specs.git'
#source 'https://github.com/pteasima/podspecs'
use_frameworks!
platform :ios, '12.0'

pod 'R.swift'

def framework_pods
  pod 'Fakery'
  pod 'Unidirectional', :git => 'git@github.com:pteasima/Unidirectional.git'
  pod 'Then'
  pod 'Closures'
end

target 'SmartContractorIos' do
  framework_pods
end

target 'SmartContractorFramework' do
  framework_pods
end

target 'SmartContractorFrameworkTests' do
  framework_pods
end
