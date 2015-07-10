require 'nokogiri'

if ENV['TRAVIS_SECURE_ENV_VARS'] != 'true'
  puts 'Sonatype password not found, skipping deployment'
  exit
end

builder = Nokogiri::XML::Builder.new do |xml|
  xml.settings {
    xml.servers {
      xml.server {
        xml.id 'ossrh'
        xml.username ENV['SONATYPE_USERNAME']
        xml.password ENV['SONATYPE_PASSWORD']
      }
    }
  }
end

path = File.join(File.expand_path('~'), '.m2', 'settings.xml')
File.open(path, 'w') { |file|
  puts 'Writing maven settings file'
  file.write builder.to_xml
}