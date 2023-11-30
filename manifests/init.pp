# @summary Install and configure f-upgrade
#
# @param config
#   A list of options and values that should be added to the f-upgrade
#   configuration file. Note that the "upgrade" option should not be listed
#   here, the parameter `$upgrade` should be used instead.
#   If an option is set to an empty string, it will be removed from the file.
#
# @param config_file
#   The path to the f-upgrade configuration file.
#
# @param cronjob_options
#   Options for the f-upgrade cron job.
#
# @param hook_dir
#   The target directory for hook files.
#
# @param hooks
#   A list of hooks. The content may be specified either directly using
#   the "content" parameter or by specifying the "source" parameter – as
#   supported by the file resource.
#
# @param manage_cronjob
#   Enables the f-upgrade cron job. By default it runs hourly to start or
#   resume the upgrade process.
#
# @param package_ensure
#   The desired state for the f-upgrade package.
#
# @param package_name
#   The name of the f-upgrade package.
#
# @param upgrade
#   The target FreeBSD version for the upgrade. When this parameter is
#   specified, the module immediately starts the f-upgrade service and
#   the upgrade process should begin only a few seconds later.
#
class f_upgrade (
  Hash $config,
  Hash $cronjob_options,
  Stdlib::Absolutepath $config_file,
  Stdlib::Absolutepath $hook_dir,
  Hash $hooks,
  Boolean $manage_cronjob,
  Enum['absent', 'installed', 'latest'] $package_ensure,
  String $package_name,
  Optional[String] $upgrade = undef,
) {
  class { 'f_upgrade::install': }
  ~> class { 'f_upgrade::config': }
  ~> class { 'f_upgrade::hooks': }
  ~> class { 'f_upgrade::service': }
}
