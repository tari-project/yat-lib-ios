Pod::Spec.new do |s|
  s.name = 'YatLib'
  s.version = '0.4.1'
  s.license = '3-Clause BSD License'
  s.summary = 'Yat partner integration library for iOS.'
  s.homepage = 'https://github.com/tari-project/yat-lib-ios'
  s.authors = { 'The Tari Development Team' => 'info@tari.com' }
  s.source = { :git => 'https://github.com/tari-project/yat-lib-ios.git', :tag => s.version }

  s.ios.deployment_target = '13.0'
  s.swift_version = '5'

  s.source_files = 'YatLib/**/*.{h,swift}'
  s.resources = 'YatLib/**/*.{lproj,xcassets,otf,json}'

  s.ios.dependency 'TariCommon', '~> 0.2.0'
end
