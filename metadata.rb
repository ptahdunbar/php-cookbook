name             'php'
maintainer       'Ptah Dunbar'
maintainer_email 'yarr@piratedunbar.com'
license          'All rights reserved'
description      'Installs/Configures php'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends 'apt'
depends 'build-essential'
depends 'xml'
depends 'git'
depends 'base'
depends 'web'

supports 'ubuntu'

recipe 'php::default', 'Installs and configures PHP-FPM and composer'
recipe 'php::composer', 'Installs composer to its install_path'
recipe 'php::package', 'Installs and configures PHP-FPM via the package manager.'
recipe 'php::ppa', 'Registers the PHP 5.4/5.5 repositories'
recipe 'php::source', 'Installs and configures PHP-FPM from source'
recipe 'php::phpbuild', 'Installs and configures phpbuild'
recipe 'php::phpenv', 'Installs and configures phpenv'