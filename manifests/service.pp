# @summary Enable and start the f-upgrade upgrade process
#
# @api private
class f_upgrade::service {
  # Only start the f-upgrade "service" if an upgrade is configured.
  if f_upgrade =~ String {
    $service_ensure = 'running'
  } else {
    # The "stop" command is not available, hence this does nothing.
    $service_ensure = 'stopped'
  }

  # f-upgrade does not provide a real service, instead the "start"
  # command initiates the upgrade process (if an upgrade is configured).
  service { 'f_upgrade':
    ensure     => $service_ensure,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
  }
}
