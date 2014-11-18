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
#         secret => 'ami_secret',}
#     # Add an ARI user
#     asterisk::config::user{'/etc/asterisk/ari.conf':
#         user   => hiera('asterisk::ari::user','ari_user),
#         secret => hiera('asterisk::ari::secret','ari_secret'),}
#
define asterisk::config::user ($target = $title, $user, $secret="") {
  validate_string($target, $user, $secret)

  # Ensure unique title based on target and username
  $safe_title = regsubst("${target}_user_${user}",'[/\.]','_')
  concat::fragment{$safe_title:
    target  => $title,
    content => "[${user}]\nsecret = ${secret}\n",
    order   => 20
  }
}
