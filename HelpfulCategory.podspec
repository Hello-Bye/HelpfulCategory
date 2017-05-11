
Pod::Spec.new do |s|

  s.name         = "HelpfulCategory"
  s.version      = "0.0.1"
  s.summary      = "A helpful category."

  s.description  = "A description of HelpfulCategory."

  s.homepage     = "https://github.com/Hello-Bye/HelpfulCategory"

  s.license      = "MIT"
  # s.license    = { :type => "MIT", :file => "FILE_LICENSE" }

  s.author       = { "Chenzuliang" => "chenzuliang@geek-zoo.com" }

  s.platform     = :ios, "8.0"

  s.frameworks = 'UIKit','Foundation', 'CoreGraphics', 'sys'

  s.source       = { :git => "https://github.com/Hello-Bye/HelpfulCategory.git", :tag => s.version }

  s.source_files  = "Category/*.{h,m}"
  # s.exclude_files = "HelpfulCategory/**/*.{h,m}"


end
