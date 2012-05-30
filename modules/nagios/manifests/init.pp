class nagios::nrpe {
	
	case $::architecture {
		i386: {
			$pluginsdir  = "/usr/lib/nagios/plugins"
		}
		default: {
			$pluginsdir  = "/usr/lib64/nagios/plugins"
		}
	}
	case $::operatingsystem {
		debian: {
			$nrpepackage   = [ "nagios-nrpe-server" ]
			$nrpeplugins   = [ "nagios-plugins" ]
			$nrpeservice   = [ "nagios-nrpe-server" ]
		}
		centos, redhat: {
			$nrpepackage   = [ "nagios-nrpe" ]
			$nrpeplugins   = [ "nagios-plugins" ]
			$nrpeservice   = [ "nrpe" ]
		}
	}
	
	package { 
		[$nrpepackage, $nrpeplugins]: 
		ensure => present,
	}
   
 	service { $pkg_name: 
		ensure => running, 
		enable => true 
	}
	 
	


	file { "/etc/nagios/nrpe.cfg":
		mode    => "644",
		owner   => root,
		group   => root,
		content => template("nagios/nrpe.cfg.erb"),
		require => Package[$nrpepackage],
	}
}