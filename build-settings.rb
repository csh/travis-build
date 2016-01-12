require 'rubygems'
require_gem 'builder', '~> 2.0'

if ENV['TRAVIS_SECURE_ENV_VARS'] != 'true'
  puts 'Repository password not found, skipping deployment'
  exit
end

builder = Builder::XmlMarkup.new
xml = builder.settings { |settings|
    settings.servers { |servers|
        servers.server { |server|
            server.id(ENV['REPOSITORY_ID'])
            server.username(ENV['REPOSITORY_USERNAME'])
            server.password(ENV['REPOSITORY_PASSWORD'])
        }
    }
}

path = File.join(File.expand_path('~'), '.m2', 'settings.xml')
File.open(path, 'w') { |file|
  puts 'Writing maven settings file'
  file.write xml
}
