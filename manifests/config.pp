# @summary Manage the f-upgrade configuration file
#
# @api private
class f_upgrade::config {
  # The 'upgrade' option must not be specified in $config.
  if ('upgrade' in $f_upgrade::config) {
    fail('f-upgrade $config parameter is invalid, it MUST NOT include the upgrade option')
  }

  # Now merge the 'upgrade' parameter into $config.
  if ($f_upgrade::upgrade != '') {
    $_config = deep_merge($f_upgrade::config, { 'upgrade' => $f_upgrade::upgrade })
  } else {
    # Set to an empty string, which will cause it to be removed
    # from the config file.
    $_config = deep_merge($f_upgrade::config, { 'upgrade' => '' })
  }

  $_config.each | String $option, Variant[String, Integer] $value| {
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
