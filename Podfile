workspace 'Foundry'
xcodeproj 'Tests/FoundryTests.xcodeproj'

inhibit_all_warnings!

target :iostests do
    platform :ios, '7.0'
    pod 'MagicalRecord'
    pod 'MBFaker', :git => 'https://github.com/foulkesjohn/MBFaker.git', :commit => 'fe54983624c134d67f9a4a81b61875df712cdf90'
    xcodeproj 'Tests/FoundryTests.xcodeproj'
end

target :osxtests do
    platform :osx, '10.9'
    pod 'MagicalRecord'
    xcodeproj 'Tests/FoundryTests.xcodeproj'
end