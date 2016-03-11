Pod::Spec.new do |s|

  s.name         = "WobbleBubbleButton"
  s.version      = "0.0.4"
  s.summary      = "Create wobble bubble buttons that same as in Game Center, although it does not look like much. Written by Swift."

  s.description  = <<-DESC
                   Create wobble bubble buttons that same as in Game Center, although it does not look like much. Written by Swift.
                   The buttons with animations is fun and attracting users. Especially, natural effects is more attractive.
                   DESC

  s.homepage     = "https://github.com/quangtqag/WobbleBubbleButton"
  s.screenshots  = "https://raw.githubusercontent.com/quangtqag/WobbleBubbleButton/master/Screenshots/preview.gif"

  s.license      = "MIT"

  s.author             = { "Quang Quoc Tran" => "quangtqag@gmail.com" }
  s.social_media_url   = "https://twitter.com/QuangQuocTran"

  s.platform     = :ios, "8.0"

  s.source       = { :git => "https://github.com/quangtqag/WobbleBubbleButton.git", :tag => s.version }

  s.source_files  = "Source/*.swift"

  s.framework  = "UIKit"

  s.requires_arc = true

end