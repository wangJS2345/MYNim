#
#  Be sure to run `pod spec lint MyNIM.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  s.name         = "MyNIM"
  s.version      = "0.0.1"
  s.summary      = "A short description of MyNIM."


  s.description  = <<-DESC
*建库测试
                   DESC

  s.homepage     = "https://github.com/wangJS2345/MYNim/"




  s.license      =  { :type => "MIT", :file => "LICENSE" }
  # s.license      = { :type => "MIT", :file => "FILE_LICENSE" }




  s.author             = { "wangjs" => "wangjs2345@163.com" }
  # Or just: s.author    = "wangjs"
  # s.authors            = { "wangjs" => "wangjs2345@163.com" }
  s.social_media_url   = "http://weibo.com/joycejs"



#s.platform = :ios, "8.0"





  s.source       = { :git => "https://github.com/wangJS2345/MYNim.git", :tag => "#{s.version}" }




  s.source_files  = "HYNim/classes/HYMegListViewController.{h,m}", "HYNim/classes/HYSessionViewController.{h,m}"
  s.exclude_files = "Classes/Exclude"

s.public_header_files = "HYNim/classes/HYMegListViewController.h", "HYNim/classes/HYSessionViewController.h"
# ――――――――――――――――――――――――― Subspec ―――――――――――――――――――――――――――――――――――――――――― #
s.subspec 'MegList' do |ss|
ss.source_files = "HYNim/classes/HYMegListViewController.{h,m}"
ss.public_header_files = "HYNim/classes/HYMegListViewController.h"
end

s.subspec 'Session' do |ss|
ss.source_files = "HYNim/classes/HYSessionViewController.{h,m}"
ss.public_header_files = "HYNim/classes/HYSessionViewController"
end




s.frameworks = "SystemConfiguration","MobileCoreServices"
s.vendored_frameworks = "Frameworks/SVProgressHUD.framework","Frameworks/NIMSDK.framework"


s.vendored_libraries = "Frameworks/libSVProgressHUD.a","Frameworks/libPods-HYNim.a"



s.dependency 'NIMSDK_LITE'
s.dependency 'NIMKit/Lite'
s.dependency 'SVProgressHUD'
end
