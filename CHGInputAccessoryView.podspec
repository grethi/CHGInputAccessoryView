Pod::Spec.new do |s|
  s.name             = "CHGInputAccessoryView"
  s.version          = "1.0.0"
  s.summary          = "Simply build an inputAccessoryView to show above a keyboard."
  s.description      = <<-DESC
This pod will help to build an inputAccessoryView as simple and fast as possible. The CHGInputAccessoryView is based on UIToolbar with all its advantages and has some prebuild items like a separator, a textfield or flexible and fixed space.
                       DESC

  s.homepage         = "https://github.com/grethi/CHGInputAccessoryView"
  s.screenshots     = "https://github.com/grethi/CHGInputAccessoryView/example.gig"
  s.license          = 'MIT'
  s.author           = { "Christian Greth" => "greth.christian@googlemail.com" }
  s.source           = { :git => "https://github.com/grethi/CHGInputAccessoryView.git", :tag => s.version.to_s }

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'CHGInputAccessoryView' => ['Pod/Assets/*.png']
  }

  s.frameworks = 'UIKit'

end
