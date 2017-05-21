Pod::Spec.new do |s|
  s.name             = "CHGInputAccessoryView"
  s.version          = "2.0.0"
  s.summary          = "Simply build an inputAccessoryView to show above a keyboard."
  s.description      = <<-DESC
This pod will help to build an inputAccessoryView as simple and fast as using a UIToolbar. The CHGInputAccessoryView is based on UIToolbar with all its advantages and comes with some prebuild items like a separator, a UITextField, a UITextView or flexible and fixed spaces.
                       DESC

  s.homepage         = "https://github.com/grethi/CHGInputAccessoryView"
  s.license          = 'MIT'
  s.author           = { "Christian Greth" => "greth.christian@googlemail.com" }
  s.source           = { :git => "https://github.com/grethi/CHGInputAccessoryView.git", :tag => s.version.to_s }

  s.platform     = :ios, '10.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'CHGInputAccessoryView' => ['Pod/Assets/*.png']
  }

  s.frameworks = 'UIKit'

end
