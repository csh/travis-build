if ENV['TRAVIS_SECURE_ENV_VARS'] != 'true'
  puts 'Repository password not found, skipping deployment'
  exit
end

repository_username = ENV['REPOSITORY_USERNAME'] || 'deployment'
repository_password = ENV['REPOSITORY_PASSWORD']

properties = "nexus_username=#{repository_username}\nnexus_password=#{repository_password}"
path = File.join(File.expand_path('~'), '.gradle')
Dir.mkdir(path) unless File.exists?(path)
path = File.join(path, 'gradle.properties')
File.open(path, 'w+') { |file|
  puts 'Writing gradle properties file'
  file.write properties
}
