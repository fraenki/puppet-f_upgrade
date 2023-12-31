# Reference

<!-- DO NOT EDIT: This document was generated by Puppet Strings -->

## Table of Contents

### Classes

#### Public Classes

* [`f_upgrade`](#f_upgrade): Install and configure f-upgrade

#### Private Classes

* `f_upgrade::config`: Manage the f-upgrade configuration file
* `f_upgrade::hooks`: Manage hook files for f-upgrade
* `f_upgrade::install`: Install f-upgrade
* `f_upgrade::service`: Enable and start the f-upgrade upgrade process

## Classes

### `f_upgrade`

Install and configure f-upgrade

#### Parameters

The following parameters are available in the `f_upgrade` class.

##### `config`

Data type: `Hash`

A list of options and values that should be added to the f-upgrade
configuration file. Note that the "upgrade" option should not be listed
here, the parameter `$upgrade` should be used instead.
If an option is set to an empty string, it will be removed from the file.

##### `config_file`

Data type: `Stdlib::Absolutepath`

The path to the f-upgrade configuration file.

##### `cronjob_options`

Data type: `Hash`

Options for the f-upgrade cron job.

##### `hook_dir`

Data type: `Stdlib::Absolutepath`

The target directory for hook files.

##### `hooks`

Data type: `Hash`

A list of hooks. The content may be specified either directly using
the "content" parameter or by specifying the "source" parameter – as
supported by the file resource.

##### `manage_cronjob`

Data type: `Boolean`

Enables the f-upgrade cron job. By default it runs hourly to start or
resume the upgrade process.

##### `package_ensure`

Data type: `Enum['absent', 'installed', 'latest']`

The desired state for the f-upgrade package.

##### `package_name`

Data type: `String`

The name of the f-upgrade package.

##### `upgrade`

Data type: `Optional[String]`

The target FreeBSD version for the upgrade. When this parameter is
specified, the module immediately starts the f-upgrade service and
the upgrade process should begin only a few seconds later.

Default value: ``undef``

