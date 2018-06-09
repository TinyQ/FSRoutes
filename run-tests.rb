#!/usr/bin/ruby

require 'fileutils'
def RAISE_IF_SYSTEM_FAILED(command)
    system command or \
        raise("\n\n ❌  command run failed : #{command} \n\n")
end

def RUN_SHELL_IN_PATH(command,path)
    path_current = Dir.pwd
    FileUtils.cd(path)
    RAISE_IF_SYSTEM_FAILED(command)
    FileUtils.cd(path_current)
end

workspace = "FSRoutesProject/FSRoutesProject.xcworkspace"
scheme = "FSRoutesProject"
sdk = `xcodebuild -showsdks | grep -o 'iphonesimulator*.*'`
destination = "'platform=iOS Simulator,name=iPhone 7,OS=10.0'"

xcodebuild_test_command = <<-EOF
xcodebuild\
 test\
 -workspace #{workspace}\
 -scheme #{scheme}\
 -destination #{destination}\
 test | xcpretty --test --color && exit ${PIPESTATUS[0]}
EOF

RUN_SHELL_IN_PATH(xcodebuild_test_command ,'.')

