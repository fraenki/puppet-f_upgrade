# @summary Manage hook files for f-upgrade
#
# @api private
class f_upgrade::hooks {
  $f_upgrade::hooks.each | String $hook, Hash $values| {
    if (('ensure' in $values) and ($values['ensure'] == 'absent')) {
      # Remove hook.
      file { "${f_upgrade::hook_dir}/${hook}":
        ensure => 'absent',
      }
    } elsif ('content' in $values) {
      # Use provided content for hook file.
      file { "${f_upgrade::hook_dir}/${hook}":
        mode    => '0644',
        content => $values['content'],
      }
    } elsif ('content' in $values) {
      # Get content from specified source.
      file { "${f_upgrade::hook_dir}/${hook}":
        mode   => '0644',
        source => $values['source'],
      }
    } else {
      fail("f-upgrade hook ${hook} is invalid, parameter content or source is required")
    }
  }
}
