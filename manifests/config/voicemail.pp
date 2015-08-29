# == Defined Type: asterisk::config::voicemail
#  Define voicemails for use with Asterisk using concat::fragment on
#  the vaoicemail.conf file.
#
# === Parameters
#  [*id*]
#    String. Voicemail id
#    REQUIRED. No Default.
#
#  [*target*]
#    String. Path to voicemail.conf.
#    REQUIRED. No Default.
#
# ==== String Parameters
#  The remaining parameters are strings as described in the Asterisk
#  manuals for voicemails.
#
define asterisk::config::voicemail (
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
