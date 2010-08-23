#### Puppet module for MCollective ###
class mcollective {

# install the "common" package required for both client and server
	package { "mcollective-common":
		ensure => present,
	}

# we need the rubgems installed as well.
	package { "rubygem-stomp":
		ensure => present,
	}


# setup the class for the "server" element - this is required on all systems that you wish to monitor/control
	class server {

		file {"/usr/libexec/mcollective/mcollective/agent/":
		       source => "puppet:///modules/mcollective/agent",
		       ensure => directory,
		       recurse => true,
		       owner => 'root',
		       mode => 0644,
		}
		file {"/usr/libexec/mcollective/mcollective/facts/":
			source => "puppet:///modules/mcollective/facts",
			ensure => directory,
			recurse => true,
			owner => 'root',
			mode => 0644,
		}

# push the server config out to the nodes
		file {"mcollective-server.cfg":
			source => "puppet:///modules/mcollective/server.cfg",
			owner => "root",
			group => "root",
			mode => 440,
			path => "/etc/mcollective/server.cfg",
		}

# install the "server" package
		package { "mcollective":
			ensure => present,
		}

# setup the service and ensure it has the relevant files and packages installed.
		service {"mcollective":
			ensure => running,
			hasrestart => true,
			require => [Package["mcollective"],File["mcollective-server.cfg"]],
			subscribe => [
				Package["mcollective"],
				File["mcollective-server.cfg"],
				File['/usr/libexec/mcollective/mcollective/facts/'],
				File['/usr/libexec/mcollective/mcollective/agent']],
		}
	}

# the class for mcollective clients
	class client {

# push the client cfg out to the nodes and subscribe to/require the package
		file {"mcollective-client.cfg":
			source => "puppet:///modules/mcollective/client.cfg",
			path => "/etc/mcollective/client.cfg",
			owner => "root",
			group => "root",
			mode => 440,
			path => "/etc/mcollective/client.cfg",
			require => Package["mcollective-client"],
			subscribe => Package["mcollective-client"],
		}

# install the package
		package { "mcollective-client":
			ensure => present,
		}

	}
}
