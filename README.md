# Depp
Depp is a **dependency-checking system for many different package managers**.
If you need something from another languages, Depp will allow you to ensure
that any packages you need are installed, and if they aren't, install them.

This was created to enable the cross-language dependency system for
[UltiTool](https://github.com/OrangeFlash81/ultitool).

## Example
Suppose my Ruby project runs some Python at some point, and that Python
depends on SciPy.

Let's use Depp to ensure that SciPy is installed:

```ruby
require 'depp'

pip = Depp::PackageManagers::Pip.new
if pip.package_status('scipy').installed?
  puts 'You\'re good to go!'
else
  puts 'Hold on, you\'re missing SciPy...'
end
```

This will work great, but we can take this a step further and install SciPy 
for the user!

```ruby
require 'depp'

pip = Depp::PackageManagers::Pip.new
if pip.package_status('scipy').installed?
  puts 'You\'re good to go!'
else
  puts 'Installing SciPy...'

  # Get the latest version of SciPy
  package = pip.packages_by_name('scipy')[-1]

  # Install it
  pip.install_package(package)

  puts 'Done!'
end
```

## Supported Languages and Roadmap
 - [X] Python (pip)
 - [ ] Ruby (gem)
 - [ ] JavaScript (npm)
 - [ ] Rust (cargo)