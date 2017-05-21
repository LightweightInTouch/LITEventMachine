#
# Be sure to run `pod lib lint LITEventMachine.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "LITEventMachine"
  s.version          = "0.0.4"
  s.summary          = "Simple safe wrapper for NSNotificationCenter and Darwin Notifications."

  s.description      = <<-DESC
  For example, you need receive a special event for making some stuff.
  You can make protocols and delegates, but it is boring.
  You can make subcription for event for Notification Center, but it is to dangerous. You should subscribe your stuff in proper order.
  You can use Swift (hah) or Objective-C (ah) with numerous libraries for event handling, that are too heavy for you.
  Or you can use lightweight safe wrapper for notification center and be ready for easy life.
                       DESC

  s.homepage         = "https://github.com/LightweightInTouch/LITEventMachine"
  s.license          = 'MIT'
  s.author           = { "Lobanov Dmitry" => "gaussblurinc@gmail.com" }
  s.source           = { :git => "https://github.com/LightweightInTouch/LITEventMachine.git", :tag => s.version.to_s }

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.public_header_files = 'Pod/Classes/**/*.h'
end
