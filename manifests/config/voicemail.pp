# == Defined Type: asterisk::config::device
#  Define SIP and IAX devices for use with Asterisk using concat::fragment on
#  the sip.conf, or iax.conf file.
#
# === Parameters
#  [*device_name*]
#    String. Name of the device.
#    REQUIRED. No Default.
#
#  [*target*]
#    String. Path to sip.conf.
#    REQUIRED. No Default.
#
#  [*type*]
#    String. Values: 'friend', 'peer', or 'user'
#    Default: 'friend'
#
# ==== Array Parameters
#  [*allow*, *disallow*, *deny*, *permit*]
#    Array of Strings. IPs or hostnames to control access.
#    Default: []
#
# ==== String Parameters
#  The remaining parameters are strings as described in the Asterisk
#  manuals for sip or iax devices.
#
define asterisk::config::device (
  $target,
  $id = $title,
  $password = '',
  $name = '',
  $mail = '',
  $pager = '',
  $options = '',
)
{
  validate_string ($target, $id, $password)

  concat::fragment{"voicemail_${id}":
    target  => $target,
    content => template('asterisk/voicemail.erb'),
    order   => '50',
  }
}
