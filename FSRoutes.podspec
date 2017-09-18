Pod::Spec.new do |s|
  s.name         = "FSRoutes"
  s.version      = "0.0.1"
  s.summary      = "URL routing library for iOS with a simple block-based API"
  s.license      = "MIT"
  s.author       = { "qfu" => "tinyqf@gmail.com" }
  s.homepage     = "https://github.com/TinyQ/FSRoutes"
  s.source       = { :git => "git@github.com:TinyQ/FSRoutes.git", :tag => "#{s.version}" }

  s.source_files  = [
    "FSRoutes/**/*.{h,m,c}"
  ]
  s.platform = :ios, '9.0'
end