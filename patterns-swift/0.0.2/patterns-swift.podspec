Pod::Spec.new do |s|
  s.name         = "patterns-swift"
  s.version      = "0.0.2"
  s.summary      = "Patterns is an easy to use, pure-Swift library for drawing patterns."
  s.description  = <<-DESC
    Patterns is an easy to use, pure-Swift library for drawing patterns so that you don't have to ship iOS apps with blank backgrounds.

    To ease the usage with interface builders, all of the patterns are made @IBDesignables, set the properties directly from the interface builder, set some constraints to the view and you are ready to go.
  DESC
  s.homepage     = "https://github.com/vinayjn/Patterns"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Vinay Jain" => "vinay.jn7@gmail.com" }
  s.social_media_url   = "https://twitter.com/vinayjn7"
  s.ios.deployment_target = "9.0"
  s.source       = { :git => "https://github.com/vinayjn/Patterns.git", :tag => s.version.to_s }
  s.source_files  = "Sources/**/*.{swift,h,m}"
  s.swift_version = "5.2"
end
