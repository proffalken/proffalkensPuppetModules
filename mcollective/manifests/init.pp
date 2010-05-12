#### Puppet module for MCollective ###

class mcollective {

	# ensure the correct repositories are set up
	# WARNING - YOU WILL NEED TO WRITE THE "repository" DEFINITION OR ENSURE THE REPO IS INSTALLED BY OTHER MEANS!
	# THE "mcollective" REPO CURRENTLY NEEDS TO BE MANUALLY CREATED FROM THE RPMS ON THE MCOLLECTIVE GOOGLE CODE
	# WEBSITE USING MREPO OR SIMILAR!
	repository { ["elff"],["mcollective"] }

	# install the "common" package required for both client and server
	package { "mcollective-common":
		ensure => present,
	}

	# we need the rubgems installed as well.
	package { "rubygem-stomp":
		ensure => present,
	}

}

# setup the class for the "server" element - this is required on all systems that you wish to monitor/control
class mcollective::server inherits mcollective {
	
	# push the server config out to the nodes
	file {"mcollective-server.cfg":
		source => "puppet:///modules/mcollective/server.cfg",
		owner => "root",
		group => "root",
		mode => 440,
		path => "/etc/mcollective/server.cfg",
	}

	# install the "server" package
	package { "mcollective-server":
		ensure => present,
	}

	# setup the service and ensure it has the relevant files and packages installed.
	service {"mcollective":
		ensure => running,
		hasrestart => true,
		require => [Package["mcollective-server"],File["mcollective-server.cfg"]],
		subscribe => [Package["mcollective-server"],File["mcollective-server.cfg"]],
	}
}

# the class for mcollective clients
class mcollective::client {

	# push the client cfg out to the nodes and subscribe to/require the package
	file {"mcollective-client.cfg":
		source => "puppet:///modules/mcollective/client.cfg",
		path => "/etc/mcollective/client.cfg",
		owner => "root",
		group => "root",
		mode => 440
		path => "/etc/mcollective/client.cfg",
		require => Package["mcollective-client"],
		subscribe => Package["mcollective-client"],
	}

	# install the package
	package { "mcollective-client":
		ensure => present,
		}

}
	
	
