# the base class from which all other classes inherit
class base {

	import "yumrepositories"

	package{"vim-enhanced":
		ensure => present,
	}

	yumrepository { "mcollective":
		title=>"mcollective",
		name=>"Mcollective and ActiveMQ packages",
		baseurl=>"http://172.16.224.254/mcollective",
		gpgcheck=>"0" 
	}
}
