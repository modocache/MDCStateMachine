platform :ios


target :test, exclusive: true do
  link_with 'MDCStateMachineTests'
  pod 'Kiwi'
end

target :integration_test, exclusive: true do
  link_with 'IntegrationTests'
  pod 'KIF', '~> 0.0.2' # https://github.com/modocache/KIFSpecs
end
