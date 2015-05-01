
node 'onix.geeksoc.org' {
    
  # Message of the day
  file { '/etc/motd':
      source => "puppet:///files/motd/onix"
    }
  
    class {'ssh::sshd':
      sshd_config_AllowGroups => 'sysadmin-games sysadmin gsag root members',
    }
    
    class {'sudo':
      sudoers => '%sysadmin-games',
    }

  # Roles
  include global
}
