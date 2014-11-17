# == Defined Type: asterisk::config::user
#  This defined type can be used to add users to INI file constructed
#  with puppetlabs/concat module.
#
# === Requirements
#  Module: puppetlabs/concat
#
# === Parameters
#  [*target*]
#    *REQUIRED* Target file that the user credentials should be stored
#    to.
#
#  [*username*]
#    *REQUIRED* Username for credentials. No default.
#
#  [*secret*]
#    Secret to log in with. Default to empty string ("").
#
# === Example
# Add a user 'asterisk' with the secret 'asterisk' for AMI service
# configuration.
#
#     class { '::asterisk':
#         manage_config => true,
#         amienabled    => 'yes',
#     }
#     # Add an AMI user
#     asterisk::config::user('/etc/asterisk/manager.conf','asterisk','asterisk')
#     # Add an ARI user
#     asterisk::config::user('/etc/asterisk/ari.conf','asterisk','asterisk')
#
define asterisk::config::user ($target, $username, $secret="") {
  validate_string($target, $username, $secret)

  # Ensure unique title based on target and username
  $title = regsubst("${target}_user_${user}",'[/\.]','_')
  concat::fragment{$title:
    target  => $target,
    content => "[${user}]\nsecret = ${secret}\n",
    order   => 20
  }
}
