# @summary Install f-upgrade
#
# @api private
class f_upgrade::install {
  package { $f_upgrade::package_name:
    ensure => $f_upgrade::package_ensure,
  }
}
