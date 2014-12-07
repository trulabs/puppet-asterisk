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
#  [*user*]
#    *REQUIRED* Username for credentials. No default.
#
#  [*secret*]
#    Secret to log in with. Default to empty string ("").
#
#  [*read*]
#    String VALUE
#    Default: undef
#
#    If defined, place the string VALUE as a keypair "read = VALUE"
#    for the user.
#
#  [*write*]
#    String VALUE
#    Default: undef
#
#    If defined, place the string VALUE as a keypair "write = VALUE"
#    for the user.
#
#  [*permit*]
#    Array of Strings
#    Default: undef
#
#    If defined, place the multiple lines of keypairs "permit = VALUE"
#    for the user.
#
#  [*deny*]
#    Array of Strings
#    Default: undef
#
#    If defined, place the multiple lines of keypairs "deny = VALUE"
#    for the user.
#
#  [*eventfilter*]
#    Array of Strings
#    Default: undef
#
#    If defined, place the multiple lines of keypairs "eventfilter = VALUE"
#    for the user.
#
# === Example
# Add a user 'asterisk' with the secret 'asterisk' for AMI service
# configuration.
#
#     class { '::asterisk':
#         manage_config   => true,
#         manager_enabled => 'yes',
#     }
#     # Add an AMI user
#     asterisk::config::user{'/etc/asterisk/manager.conf':
#         user   => 'ami_user',
#         secret => 'ami_secret',
#         read   => 'all',
#     }
#     # Add an ARI user
#     asterisk::config::user{'/etc/asterisk/ari.conf':
#         user   => hiera('asterisk::ari::user','ari_user'),
#         secret => hiera('asterisk::ari::secret','ari_secret'),}
#
define asterisk::config::user (
  $user,
  $target      = $title,
  $secret      = '',
  $read        = '',
  $write       = '',
  $deny        = [],
  $permit      = [],
  $eventfilter = [],
) {
  validate_string($target, $user, $secret)
  validate_string($read, $write)
  validate_array($permit, $deny, $eventfilter)

  # Ensure unique title based on target and username
  $safe_title = regsubst("${target}_user_${user}",'[/\.]','_')
  concat::fragment{$safe_title:
    target  => $target,
    content => template('asterisk/user.erb'),
    order   => '20'
  }
}
