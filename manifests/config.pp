# @summary Manage the f-upgrade configuration file
#
# @api private
class f_upgrade::config {
  $f_upgrade::config.each | String $option, Variant[String, Integer] $value| {
    if ($value != '') {
      file_line { "set f-upgrade option ${option}":
        ensure             => 'present',
        path               => $f_upgrade::config_file,
        line               => "${option}=\'${$value}\'",
        match              => "^${option}=",
        append_on_no_match => true,
      }
    } else {
      # When $value is set to an empty string, remove the option from
      # the configuration files.
      file_line { "remove f-upgrade option ${option}":
        ensure            => 'absent',
        path              => $f_upgrade::config_file,
        match             => "^${option}=",
        match_for_absence => true,
        multiple          => true,
      }
    }
  }
}
