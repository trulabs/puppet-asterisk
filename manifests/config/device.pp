# == Defined Type: asterisk::config::device
#  Define SIP devices for use with Asterisk using concat::fragment on
#  the sip.conf file.
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
#  manuals for sip devices.
#
define asterisk::config::device (
  $device_name = $title,
  $target,
  $type = 'friend',
  $accountcode = '',
  $allow = [],
  $allowoverlap = '',
  $allowsubscribe = '',
  $allowtransfer = '',
  $amaflags = '',
  $busylevel = '',
  $callbackextension = '',
  $callcounter = '',
  $callerid = '',
  $callgroup = '',
  $callingpres = '',
  $contactdeny = '',
  $contactpermit = '',
  $context = '',
  $defaultip = '',
  $defaultuser = '',
  $deny = [],
  $directmedia = '',
  $directmediadeny = '',
  $directmediapermit = '',
  $disallow = [],
  $dtmfmode = '',
  $encryption = '',
  $fromdomain = '',
  $fromuser = '',
  $host = '',
  $ignoresdpversion = '',
  $insecure = '',
  $language = '',
  $mailbox = '',
  $maxcallbitrate = '',
  $maxforwards = '',
  $md5secret = '',
  $nat = '',
  $outboundproxy = '',
  $permit = '',
  $pickupgroup = '',
  $port = '',
  $progressinband = '',
  $promiscredir = '',
  $qualify = '',
  $qualifyfreq = '',
  $regexten = '',
  $registertrying = '',
  $remotesecret = '',
  $rfc2833compensate = '',
  $rtpholdtimeout = '',
  $rtptimeout = '',
  $secret = '',
  $sendrpid = '',
  $session_expires = '',
  $session_minse = '',
  $session_refresher = '',
  $session_timers = '',
  $setvar = '',
  $subscribecontext = '',
  $t38pt_usertpsource = '',
  $template = '',
  $timerb = '',
  $timert1 = '',
  $transport = '',
  $trustrpid = '',
  $unsolicited_mailbox = '',
  $use_q850_reason = '',
  $useclientcode = '',
  $username = '',
  $videosupport = '',
)
{
  validate_array ($allow, $disallow)
  validate_array ($deny, $permit)
  validate_string ($target, $type, $accountcode)
  validate_string ($allowoverlap, $allowsubscribe, $allowtransfer,)
  validate_string ($amaflags, $busylevel, $callbackextension,)
  validate_string ($callcounter, $callerid, $callgroup, $callingpres,)
  validate_string ($contactdeny, $contactpermit, $context, $defaultip,)
  validate_string ($defaultuser, $directmedia,)
  validate_string ($directmediadeny,$directmediapermit)
  validate_string ($dtmfmode, $encryption, $fromdomain, $fromuser,)
  validate_string ($host, $ignoresdpversion, $insecure, $language,)
  validate_string ($mailbox, $maxcallbitrate, $maxforwards,)
  validate_string ($md5secret, $nat, $outboundproxy)
  validate_string ($pickupgroup, $port, $progressinband,)
  validate_string ($promiscredir, $qualify, $qualifyfreq, $regexten,)
  validate_string ($registertrying, $remotesecret)
  validate_string ($rfc2833compensate, $rtpholdtimeout, $rtptimeout,)
  validate_string ($secret, $sendrpid, $session_expires,)
  validate_string ($session_minse, $session_refresher,)
  validate_string ($session_timers, $setvar, $subscribecontext,)
  validate_string ($t38pt_usertpsource)
  validate_string ($template, $timerb, $timert1, $transport,)
  validate_string ($trustrpid, $unsolicited_mailbox, $use_q850_reason,)
  validate_string ($useclientcode, $username, $videosupport)

  $types = ['friend', 'peer', 'user']
  unless $type in ($types) {
    fail("Device ${device_name} type ${type} must be in ${types}.")
  }

  if size($allow) > 1 {
    unless $disallow[0] == 'all' {
      fail("Device ${device_name}: If using multiple `allow` parameters, you must set `disallow => ['all']`.")
    }
  }

  if size($disallow) > 1 {
    unless $allow[0] == 'all' {
      fail("Device ${device_name}: If using multiple `disallow` parameters, you must set `allow => ['all']`.")
    }
  }

  concat::fragment{"sip_device_${device_name}":
    target  => $target,
    content => template('asterisk/device.erb'),
    order   => 50,
  }
}
