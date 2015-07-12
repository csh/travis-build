travis-build
============

Automated things for Travis CI.

### Usage

#### HTTPS

```bash
$ git submodule add https://github.com/Fireflies/travis-build.git build
```

#### SSH

```bash
$ git submodule add git@github.com:Fireflies/travis-build.git build
```

### Configuration

Once you've added this repository as a submodule you must update your Travis configuration to execute the `build` script.

```yaml
language: java
jdk: oraclejdk8
before_script:
- bundle install --gemfile build/Gemfile
- ruby build/build-settings.rb
script: ruby build/build.rb
```
