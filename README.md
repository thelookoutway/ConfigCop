# ConfigCop 🎛👮‍♀️

[![SPM](https://img.shields.io/badge/spm-compatible-brightgreen.svg?style=for-the-badge)](https://swift.org/package-manager)
![Platforms](https://img.shields.io/badge/Platforms-macOS-blue.svg?style=for-the-badge)
[![license](https://img.shields.io/github/license/fivegoodfriends/ConfigCop.svg?style=for-the-badge)](https://github.com/fivegoodfriends/ConfigCop/blob/master/LICENSE)

A Swift command line application that verifies `.xcconfig` files against a template.

This tool will iterate over a template of keys that you provide, checking that all of the keys are present in a given `xcconfig` file. If you have multiple config files, e.g. for a "white label" app, automatically checking these as part of CI can be useful.

You can run this tool ad-hoc, or perhaps add it as a build phase script in your Xcode project.

## Installation

### Make (Recommended)

This will build the command line application and install it to `/usr/local/bin`.

```bash
$ git clone https://github.com/fivegoodfriends/ConfigCop.git
$ cd ConfigCop
$ make
```

### Swift Package Manager

```bash
$ git clone https://github.com/fivegoodfriends/ConfigCop.git
$ cd ConfigCop
$ swift build
```
After building with SPM you can manually copy the executable file to any location you like, such as `/usr/local/bin` or run `$ make` to do this for you.

## Creating a Template File

In order to verify your xcconfig files, a template is needed to compare against. You can create this template file anywhere, in your project probably makes sense.

A section named `required:` is required so that there is something to compare against. The `optional:` section is for, well, optional keys.
Put all keys that *must* appear in your `xcconfig` file(s) in the required list. Optional keys will not cause the application to fail, but wil generate a warning if they are missing from the config.

Here is an example file called `AppConfigTemplate.yml`:

```yml
required:
  - MARKETING_VERSION
  - SWIFT_VERSION
  - ENABLE_BITCODE
  - PRODUCT_BUNDLE_IDENTIFIER
  - BASE_URL
optional:
  - TEST_URL
```

## Usage

Assuming `/usr/local/bin` is in your `$PATH` you can run as follows:

```bash
configcop -c ~/iOSApp/Configs/Debug.xcconfig -t ~/Code/iOSApp/Configs/ConfigTemplate.yml
```
