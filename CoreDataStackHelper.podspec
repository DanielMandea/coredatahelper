#
# Be sure to run `pod lib lint CoreDataStackHelper.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'CoreDataStackHelper'
  s.version          = '0.1.1'
  s.summary          = 'Lightweight CoreData helper for creting / saving anf fetching NSManageObjects'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
This pod in intended to enhance the work with light core data stacks.
You can find helpers for the following needs:
1. Create single instances from a single NSManagedObject subclass based form some data
2. Create multiple instances from a single NSManagedObject subclass based on an array of data
3. Create and save multiple / single instances fo NSManagedObject subclass
4. Clean and light way of fetching NSManagedObject subclasses
Please check example project in order to get in touch with what this pod can do.
                       DESC

  s.homepage         = 'https://github.com/DanielMandea/CoreDataHelper'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'DanielMandea' => 'daniel.mandea@ro.ibm.com' }
  s.source           = { :git => 'https://github.com/DanielMandea/CoreDataHelper.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/MandeaDaniel'

  s.ios.deployment_target = '8.0'

  s.source_files = 'CoreDataStackHelper/Classes/**/*'
  
  # s.resource_bundles = {
  #   'CoreDataStackHelper' => ['CoreDataStackHelper/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
