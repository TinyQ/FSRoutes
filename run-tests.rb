#!/usr/bin/ruby

workspace = "FSRoutesProject/FSRoutesProject.xcworkspace"
scheme = "FSRoutesProject"
sdk = `xcodebuild -showsdks | grep -o 'iphonesimulator*.*'`
destination = "'platform=iOS Simulator,name=iPhone X,OS=#{sdk[15..18]}'"

xcodebuild_test_command = <<-EOF
xcodebuild\
 test\
 -workspace #{workspace}\
 -scheme #{scheme}\
 -destination #{destination}\
 test | xcpretty --test --color && exit ${PIPESTATUS[0]}
EOF

system xcodebuild_test_command
