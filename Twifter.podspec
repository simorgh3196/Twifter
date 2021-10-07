Pod::Spec.new do |s|
  s.name             = "Twifter"
  s.version          = "0.2.0"
  s.summary          = "pure-Swift library for Twitter client"
  s.homepage         = "https://github.com/simorgh3196/Twifter"
  s.license          = 'MIT'
  s.author           = { "Tomoya Hayakawa" => "simorgh3196@gmail.com" }
  s.source           = { :git => "https://github.com/simorgh3196/Twifter.git", :tag => "#{s.version}" }
  s.social_media_url = 'https://twitter.com/simorgh3196'
  s.platform         = :ios, '11.0'
  s.requires_arc     = true
  s.swift_version    = '5.5'

  s.source_files  = 'Sources/Twifter/**/*.{swift}'
  s.resources     = "Sources/Twifter/**/*"
end
