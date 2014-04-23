workspace 'Foundry'
xcodeproj 'Tests/FoundryTests.xcodeproj'

inhibit_all_warnings!

target :iostests do
    platform :ios, '7.0'
    pod 'MagicalRecord'
    pod 'Gizou', :git => 'https://github.com/smyrgl/Gizou.git'
    xcodeproj 'Tests/FoundryTests.xcodeproj'
end

target :osxtests do
    platform :osx, '10.9'
    pod 'MagicalRecord'
    pod 'Gizou'
    xcodeproj 'Tests/FoundryTests.xcodeproj'
end