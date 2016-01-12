version = `mvn help:evaluate -Dexpression=project.version`
version = version.split("\n").grep(/^[^\[]/)
version = version[0] || nil
if version.nil? || version.to_s.strip.length == 0
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

