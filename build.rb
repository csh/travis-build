require 'nokogiri'

version = nil

File.open('pom.xml', 'r') { |file|
  puts 'Locating project version'
  doc = Nokogiri::XML(file)
  doc.remove_namespaces!
  elem = doc.xpath '/project/version'
  if elem.nil?
    return
  end
  version = elem.text
}

if version.nil?
  puts 'Could not find project version'
  exit 1
end

arguments = ARGV
profiles = []
goals = [
    'clean'
]

if ENV['TRAVIS_PULL_REQUEST'] === 'false' and version.end_with? '-SNAPSHOT'
  profiles.push 'deployment'
  goals.push 'deploy'
else
  goals.push 'verify'
end

arguments.push goals
if profiles.count > 0
  arguments.push '-P' + profiles.join(',')
end

command = 'mvn ' + arguments.join(' ')
puts '$ ' + command
exit system(command)