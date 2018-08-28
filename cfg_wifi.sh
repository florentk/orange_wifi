INTERFACE=$1

ifconfig $INTERFACE up
iwconfig $INTERFACE ap auto
iwlist  $INTERFACE scan > AP
iwconfig $INTERFACE essid orange
dhclient $INTERFACE
