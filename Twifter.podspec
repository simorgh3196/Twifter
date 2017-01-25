Pod::Spec.new do |s|
  s.name             = "Twifter"
  s.version          = "0.0.2"
  s.summary          = "Library of manage twitterAPI for iOS written in Swift"
  s.homepage         = "https://github.com/simorgh3196/Twifter"
  s.license          = 'MIT'
  s.author           = { "Tomoya Hayakawa" => "simorgh3196@gmail.com" }
  s.source           = { :git => "https://github.com/simorgh3196/Twifter.git", :tag => "#{s.version}" }
  s.social_media_url = 'https://twitter.com/Sim_progra'
  s.platform         = :ios, '9.0'
  s.requires_arc     = true

  s.source_files  = 'Twifter/**/*.{swift}'
  s.resources     = "Twifter/**/*"

  s.dependency 'APIKit', '3.1.1'
end
