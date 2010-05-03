# class to manage yum repos

# define the class with a noop to load it

# Class: yumrepositories
#
# This class enables a repository to be specified much the same as any other resource
# 
# Parameters:
#	$srcpkg:
#		A URL to an RPM (if available) to install the repository
#	$title:
#		The title of the repository, used as the file name and in the repo file itself
#	$name:
#		A description of the repository (i.e. "Epel for Centos 5.4" or "mcollective custom repository")
#	$baseurl:
#		The value for the baseurl parameter in the repo file
#	$mirrorlist:
#		The mirror list for the mirrorlist parameter in the repo file
#	$failovermethod:
#		The value for the failovermethod parameter in the repo file
#	$enabled:
#		Whether this repo is enabled or not (default => true)
#	$gpgcheck:
#		Whether this repo should be checked against a GPG key (default => true)
#	$gpgkey:
#		The path/URL to the GPG-KEY for this repository
#
# Actions:
#	Define the repository and push the template based upon the parameters given
#
# Sample Usage:
#	yumrepository { "mcollective":
#                title=>"mcollective",
#                name=>"Mcollective and ActiveMQ packages",
#                baseurl=>"http://172.16.224.254/mcollective",
#                gpgcheck=>"0" 
#	        }
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
	                content => template("yumrepositories/repo.template.rb"),
	        }
	}
}

