#### Puppet module for MCollective ###

class mcollective {
	repository { "elff" }

	package { "mcollective-common":
		ensure => present,
	}

}

class mcollective::server inherits mcollective {
	
	package { "mcollective-server":
		ensure => present,
		require => File["mcollective-server.cfg"],
	}

	service {"mcollective":
		ensure => present,
		hasrestart => true,
		require => [Package["mcollective-server"],File["mcollective-server.cfg"]],
		subscribe => [Package["mcollective-server"],File["mcollective-server.cfg"]],
	}
}
