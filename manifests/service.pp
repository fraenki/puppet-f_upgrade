# @summary Enable and start the f-upgrade upgrade process
#
# @api private
class f_upgrade::service {
  # Only start the f-upgrade "service" if an upgrade is configured.
  if ($f_upgrade::upgrade =~ String and $f_upgrade::upgrade != '') {
    $service_ensure = 'running'
  } else {
    # f-upgrade does not provide a "stop" command, hence this does nothing.
    $service_ensure = 'stopped'
  }

  # f-upgrade is not a real service, instead the "start" command
  # initiates the upgrade process (if a valid upgrade is configured).
  service { 'f_upgrade':
    ensure     => $service_ensure,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
  }
}
