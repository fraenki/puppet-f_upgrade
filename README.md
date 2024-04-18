# puppet-f_upgrade

[![Puppet Forge](https://img.shields.io/puppetforge/v/fraenki/f_upgrade.svg)](https://forge.puppetlabs.com/fraenki/f_upgrade)
[![Puppet Forge](https://img.shields.io/puppetforge/f/fraenki/f_upgrade.svg)](https://forge.puppetlabs.com/fraenki/f_upgrade)

#### Table of Contents

1. [Overview](#overview)
1. [Requirements](#requirements)
1. [Usage](#usage)
    - [Basic usage](#basic-usage)
    - [Custom configuration](#custom-configuration)
    - [Using hooks](#using-hooks)
1. [Reference](#reference)
1. [Development](#development)
    - [Contributing](#contributing)

## Overview

A Puppet module to install and configure the [f-upgrade](https://github.com/fraenki/f-upgrade) service. It automates the process of installing FreeBSD operating system updates.

## Usage

### Basic usage

Assuming that the system is currently running FreeBSD 13.2 and should be upgraded to FreeBSD 14.0, the following configuration should be used:

```puppet
class { 'f_upgrade':
  upgrade => '14.0',
}
```

**NOTE:** Please read the [f-upgrade documentation](https://github.com/fraenki/f-upgrade) carefully before attempting an operating system upgrade.

### Custom configuration

In order to change the f-upgrade configuration file, options may be added to the `$config` parameter:

```puppet
class { 'f_upgrade':
  config  => {
    free_diskspace => 2048,
    log_debug      => 2,
    task_timeout   => 28800,
  },
  upgrade => '14.0',
}
```

### Using hooks

Hooks make it possible to customize the upgrade process. They need to have valid POSIX shell syntax. Hooks may either be specified directly using the `content` parameter or by specifying an alternative download source using the `source` parameter:

```puppet
class { 'f_upgrade':
  hooks => {
    '1000.pre' => {
      content => "echo hello world\n exit 0",
    },
    '1000.post.14' => {
      content => "echo task 1000 completed\n exit 0",
    },
    '5000.post.14.0' => {
      source => 'puppet:///modules/example/hook_5000.sh',
    },
    '8000.post.12.2' => {
      ensure => absent,
    },
  },
  upgrade => '14.0',
}
```

Note that hooks can be removed by adding `ensure => absent`.

## Reference

Classes and parameters are documented in [REFERENCE.md](REFERENCE.md).

## Development

### Contributing

Please use the GitHub issues functionality to report any bugs or requests for new features. Feel free to fork and submit pull requests for potential contributions.
