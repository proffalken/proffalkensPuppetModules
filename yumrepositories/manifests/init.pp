# class to manage yum repos

# define the class with a noop to load it
class yumrepositories {
	# 	noop
}


define yumrepository ($srcpkg = $srcpkg,$title=$title,$name=$name,$baseurl = $baseurl,$mirrorlist = $mirrorlist,$failovermethod=$failovermethod,$enabled = "1",$gpgcheck = "1",$gpgkey = $gpgkey) {
	
	if($srcpkg != ""){
		exec { "install-rpm":
		command => "rpm -Uh ${srcpkg}",
		}
	}
	else
	{
		file { "/etc/yum.repos.d/$title.repo":
			owner   => root,
	                group   => root,
	                mode    => 644,
	                content => template("/usr/share/puppet/modules/yumrepositories/templates/repo.template.rb"),
	        }
	}
}

