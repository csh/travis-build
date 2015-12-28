travis-build
============

Automated things for Travis CI.

BASH script variant. Passwords will not be escaped. Only works with maven, gradle support is 
not planned for now.

### Usage

#### HTTPS

```bash
$ git submodule add -b bash https://github.com/Fireflies/travis-build.git build
```

#### SSH

```bash
$ git submodule add -b bash git@github.com:Fireflies/travis-build.git build
```

### Configuration

Once you've added this repository as a submodule you must update your Travis configuration to execute the `build` script.

```yaml
language: java
jdk: oraclejdk8
before_script:
- bash build/build-settings.sh
script: bash build/build.sh
```
