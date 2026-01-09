Pod::Spec.new do |spec|

  spec.name                     = "LinWearKit"
  spec.version                  = "1.0.2"
  spec.summary                  = "LinWearKit 智能设备 SDK for iOS"
  spec.description              = <<-DESC
                                  LinWearKit 智能设备的 iOS 框架，负责与智能设备通信等功能的封装。
                                  DESC
  spec.homepage                 = "https://github.com/wsr1949/LinWearKit/tree/#{spec.version}/LinWearKit"
  spec.license                  = 'MIT'
  spec.author                   = { "wsr1949" => "921903719@qq.com" }
  spec.social_media_url         = 'https://github.com/wsr1949'
  spec.platform                 = :ios, '14.0'
  spec.source                   = { :git => "https://github.com/wsr1949/LinWearKit.git", :tag => spec.version.to_s }
  spec.documentation_url        = 'https://github.com/wsr1949/LinWearKit/blob/main/README.md'
  spec.requires_arc             = true
  spec.frameworks               = 'CoreBluetooth'

  spec.vendored_frameworks      = 'XCFramework/LinWearKit.xcframework'
  
  spec.dependency 'Protobuf'
  spec.dependency 'libopus'
  spec.dependency 'MJExtension'

  spec.pod_target_xcconfig      = { 
                                    'OTHER_LDFLAGS' => '-lObjC',
                                    'BUILD_LIBRARY_FOR_DISTRIBUTION' => 'YES'
                                  }
  
end
