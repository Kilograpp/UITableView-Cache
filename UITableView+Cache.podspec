Pod::Spec.new do |s|
  s.name             = "UITableView+Cache"
  s.version          = "0.2.2"
  s.summary          = "The open source UITableView cache category."
  s.homepage         = "https://github.com/Kilograpp/UITableView-Cache.git"
  s.author           = { "Mehdzor" => "maxim@kilograpp.com" }
  s.source           = { :git => "https://github.com/Kilograpp/UITableView-Cache.git", :tag => s.version }
  s.platform     = :ios, '6.0'
  s.requires_arc = true
  s.source_files = 'src/*.{h,m}'
  s.frameworks   = ['Foundation', 'UIKit']
  s.license      = {
    :type => 'MIT',
    :file => 'LICENSE'
  }
end

