package { "python-software-properties":
  ensure  => "installed"
}

# install ruby
exec { "install_ruby":
    command => "/usr/bin/apt-get install ruby",
}

package { "ruby":
    ensure  => "installed",
    # easier to read require
    require => Exec["install_ruby"],
}

exec { "apt-get update":
  command => "/usr/bin/apt-get update"
}

exec { "apt-get -y install libfontconfig":
  command => "/usr/bin/apt-get -y install libfontconfig"
}

exec { "apt-get install ruby-dev":
  command => "/usr/bin/apt-get -y install ruby-dev",
  require     => Package [ "ruby" ]
}

package { "git":
  ensure  => "installed",
  require => Exec [ "apt-get update" ]
}

exec { '/usr/bin/git config --global url."https://".insteadOf git://':
  user        => "vagrant",
  environment => "HOME=/home/vagrant",
  require     => Package [ "git" ]
}

file { '/home/vagrant/.gitconfig':
  ensure => "present"
}

package { "npm":
  ensure  => "installed",
  require => Exec [ "apt-get update" ]
}

package { "nodejs":
  ensure  => "installed",
  require => Exec [ "apt-get update" ]
}

file { '/usr/bin/node':
   ensure => 'link',
   target => '/usr/bin/nodejs',
}

exec { "/usr/bin/npm install -g yo":
  user      => "root",
  logoutput => "on_failure",
  creates   => "/usr/local/bin/yo",
  require   => Package [ "npm" ]
}

exec { "/usr/bin/npm install -g generator-angular":
  user      => "root",
  logoutput => "on_failure",
  creates   => "/usr/local/lib/node_modules/generator-angular",
  require   => Exec [ "/usr/bin/npm install -g yo" ]
}


exec { "/usr/bin/npm install -g grunt-cli":
  user      => "root",
  logoutput => "on_failure",
  creates   => "/usr/local/lib/node_modules/grunt-cli",
  require   => Package [ "npm" ]
}

exec { "/usr/bin/npm install -g grunt-legacy-util":
  user      => "root",
  logoutput => "on_failure",
  creates   => "/usr/local/lib/node_modules/grunt-legacy-util",
  require   => Exec [ "/usr/bin/npm install -g grunt-cli" ]
}

exec { "/usr/bin/npm install -g grunt-legacy-log":
  user      => "root",
  logoutput => "on_failure",
  creates   => "/usr/local/lib/node_modules/grunt-legacy-util",
  require   => Exec [ "/usr/bin/npm install -g grunt-cli" ]
}

exec { "/usr/bin/npm install -g bower":
  user      => "root",
  logoutput => "on_failure",
  creates   => "/usr/local/lib/node_modules/bower",
  require   => Package [ "npm" ]
}

exec { "/usr/bin/npm install -g forever":
  user      => "root",
  logoutput => "on_failure",
  creates   => "/usr/local/lib/node_modules/forever",
  require   => Package [ "npm" ]
}

exec { "/usr/bin/npm install -g protractor":
  user      => "root",
  logoutput => "on_failure",
  creates   => "/usr/local/lib/node_modules/protractor",
  require   => Package [ "npm" ]
}

exec { "/usr/bin/npm install -g generator-meanjs":
  user      => "root",
  logoutput => "on_failure",
  creates   => "/usr/local/lib/node_modules/generator-meanjs",
  require   => Exec [ "/usr/bin/npm install -g yo" ]
}

exec { "/usr/bin/npm install -g jshint":
  user      => "root",
  logoutput => "on_failure",
  creates   => "/usr/local/lib/node_modules/jshint",
  require   => Package [ "npm" ]
}


# install gem - THIS NEED SOME KIND OF creates VERIFICATION TO STOP IT FROM RUNNING AGAIN
exec { "/usr/bin/gem install compass":
  user      => "root",
  logoutput => "on_failure",
  require   => Package [ "ruby" ]
}
