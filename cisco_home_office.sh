#!/bin/bash

#
# This a script to setup a dual honed MAC to connect to a public internet available network (Sonnet Network)
# and to connect to an ethernet connected private network.  (VPN network).  This is through a second router
# that has access to the private network.
#
# TLDR; - If you have two routers, one for the public internet and another to a private network to a corporate VPN.
#    Basically I just add a bunch of specific routes and change the main DNS server to be the corporate LAN DNS server
#    because it can resolve public IP addresses as well as the private ones.
#
# "${CISCO_INTERFACE}" - is the private network
#
# en4 is the public network

usage () {
cat <<HEREDOC

  Pass in the options 'start', 'stop', 'restart' to enable or disable accessing your private network features
    at the same time as letting your non private web browsing still be the primary route.


  I usually have an alias setup in my ~/.bash_profile that looks like this:

  alias cisco-off='/Users/snoby/Desktop/terminal/cisco_home_office.sh stop'
  alias cisco-on='/Users/snoby/Desktop/terminal/cisco_home_office.sh start'

  That way I can just call 'cisco-on' or 'cisco-off' when I want too.

  YOU MUST PUT IN YOUR DEFAULTS IN THIS FILE BELOW!!!!!!

  -----------------------------------------------------------
  (DOES NOT WORK YET)  Pass in cisco-only to make cisco interface top priority
  (DOES NOT WORK YET) Pass in home-only to make the home interface top priority

HEREDOC

}

# some basic error checking
if [ -z "$1" ]; then usage; exit; fi
if [ "--help" == "$1" ]; then usage; exit; fi

CISCO_INTERFACE=en8
CISCO_DNS=64.102.6.247
HOME_INTERFACE="10G"
HOME_DNS=10.0.0.1


HOME_INTERFACE_NAME="10G"
CISCO_INTERFACE_NAME="Cisco"

HOME_INTERFACE_DEVICE_ID=$(networksetup -listnetworkserviceorder | grep "$HOME_INTERFACE_NAME" -A2 | awk -F ':' '{print substr($3, 1, length($3)-1)}' | tr -d '\n')
CISCO_INTERFACE_DEVICE_ID=$(networksetup -listnetworkserviceorder | grep "$CISCO_INTERFACE_NAME" -A2 | awk -F ':' '{print substr($3, 1, length($3)-1)}' | tr -d '\n')


echo "HOME INTERFACE_DEVICE_ID = $HOME_INTERFACE_DEVICE_ID"
echo "CISCO INTERFACE_DEVICE_ID = $CISCO_INTERFACE_DEVICE_ID"

#Global array value needed to list out interfaces
NEW=()

create_route() {
sudo networksetup -setnetworkserviceenabled "$HOME_INTERFACE" on
sudo sysctl -w net.inet.ip.forwarding=1





# Add routes for cisco specific servers that we know about.
sudo route -n add -net 173.36 -interface "${CISCO_INTERFACE}"
sudo route -n add -net 173.37 -interface "${CISCO_INTERFACE}"
sudo route -n add -net 173.38 -interface "${CISCO_INTERFACE}"
sudo route -n add -net 173.39 -interface "${CISCO_INTERFACE}"
sudo route -n add -net 171.68 -interface "${CISCO_INTERFACE}"
sudo route -n add -net 171.69 -interface "${CISCO_INTERFACE}"
sudo route -n add -net 171.70 -interface "${CISCO_INTERFACE}"
sudo route -n add -net 171.71 -interface "${CISCO_INTERFACE}"
sudo route -n add -net 161.144 -interface "${CISCO_INTERFACE}"
sudo route -n add -net 114.29 -interface "${CISCO_INTERFACE}"
#
sudo route -n add -net 3.13  -interface "${CISCO_INTERFACE}"
sudo route -n add -net 3.16  -interface "${CISCO_INTERFACE}"
sudo route -n add -net 3.228  -interface "${CISCO_INTERFACE}"
sudo route -n add -net 10.1.0.0/16  -interface "${CISCO_INTERFACE}"
sudo route -n add -net 10.2.0.0/15  -interface "${CISCO_INTERFACE}"
sudo route -n add -net 10.4.0.0/14  -interface "${CISCO_INTERFACE}"
sudo route -n add -net 10.8.0.0/13   -interface "${CISCO_INTERFACE}"
sudo route -n add -net 10.16.0.0/12  -interface "${CISCO_INTERFACE}"
sudo route -n add -net 10.32.0.0/13  -interface "${CISCO_INTERFACE}"
#
sudo route -n add -net 10.40.0.0/13 -interface "${CISCO_INTERFACE}"
sudo route -n add -net 10.48.0.0/12 -interface "${CISCO_INTERFACE}"
sudo route -n add -net 10.83.6.32/27 -interface "${CISCO_INTERFACE}"
sudo route -n add -net 10.64.0.0/10 -interface "${CISCO_INTERFACE}"
sudo route -n add -net 10.128.0.0/10 -interface "${CISCO_INTERFACE}"
sudo route -n add -net 10.192.0.0/11 -interface "${CISCO_INTERFACE}"
sudo route -n add -net 10.224.0.0/32 -interface "${CISCO_INTERFACE}"
sudo route -n add -net 10.226.0.0/16 -interface "${CISCO_INTERFACE}"
sudo route -n add -net 10.230 -interface "${CISCO_INTERFACE}"
sudo route -n add -net 10.252 -interface "${CISCO_INTERFACE}"
sudo route -n add -net 13.59.86/22 -interface "${CISCO_INTERFACE}"
sudo route -n add -net 13.59.223/24 -interface "${CISCO_INTERFACE}"
sudo route -n add -net 13.56.118.0/24 -interface "${CISCO_INTERFACE}"

sudo route -n add -net 18.211.0.0/14  -interface "${CISCO_INTERFACE}"

#

sudo route -n add -net 23.96.0.0/13 -interface "${CISCO_INTERFACE}"
sudo route -n add -net 52.96.0.0/16 -interface "${CISCO_INTERFACE}"

sudo route -n add -net 40.64.0.0/10 -interface "${CISCO_INTERFACE}"

sudo route -n add -net 64.100.0.0/14 -interface "${CISCO_INTERFACE}"
sudo route -n add -net 64.104.0.0/16 -interface "${CISCO_INTERFACE}"
sudo route -n add -net 64.112.0.0/12 -interface "${CISCO_INTERFACE}"
sudo route -n add -net 64.128.0.0/10 -interface "${CISCO_INTERFACE}"
sudo route -n add -net 64.192.0.0/11 -interface "${CISCO_INTERFACE}"
sudo route -n add -net 64.224.0.0/32 -interface "${CISCO_INTERFACE}"

sudo route -n add -net 66.114.0.0/12 -interface "${CISCO_INTERFACE}"
sudo route -n add -net 69.162.64.0/18 -interface "${CISCO_INTERFACE}"


sudo route -n add -net 72.163 -interface "${CISCO_INTERFACE}"

sudo route -n add -net 104.208.0.0/13 -interface "${CISCO_INTERFACE}"

sudo route -n add -net 148.62.40.0/24 -interface "${CISCO_INTERFACE}"
sudo route -n add -net 149.96 -interface "${CISCO_INTERFACE}"
sudo route -n add -net 161.44 -interface "${CISCO_INTERFACE}"
sudo route -n add -net 172.16 -interface "${CISCO_INTERFACE}"
sudo route -n add -net 172.18 -interface "${CISCO_INTERFACE}"
sudo route -n add -net 192.168.111 -interface "${CISCO_INTERFACE}"
sudo route -n add -net 199.91.0.0/16 -interface "${CISCO_INTERFACE}"
sudo route -n add -net 207.182.170/16 -interface "${CISCO_INTERFACE}"

#
# because Cisco throttles uploads to dockerhub
# we route dockerhub through the VPN interface
#
sudo route -n add -net 217.70.184.38/31 -interface "${CISCO_INTERFACE}"

# for aws cloud instances

sudo route -n add -net 52.0.0.0/6 -interface "${CISCO_INTERFACE}"
#
#
# Set DNS for Cisco networks
#
#sudo networksetup -setdnsservers Sonnet 64.102.6.247 "${HOME_DNS}"
sudo networksetup -setdnsservers "$HOME_INTERFACE" "$CISCO_DNS" "${HOME_DNS}"
sudo killall -HUP mDNSResponder;sudo killall mDNSResponderHelper;sudo dscacheutil -flushcache

}

delete_route() {

sudo sysctl -w net.inet.ip.forwarding=1
#sudo networksetup -setnetworkserviceenabled Sonnet off
# delete routes for cisco specific servers that we know about.

sudo route -n delete -net 3.13  -interface "${CISCO_INTERFACE}"
sudo route -n delete -net 3.16  -interface "${CISCO_INTERFACE}"
sudo route -n delete -net 3.228  -interface "${CISCO_INTERFACE}"
sudo route -n delete -net 148.62.40.0/24 -interface "${CISCO_INTERFACE}"
sudo route -n delete -net 149.96 -interface "${CISCO_INTERFACE}"
sudo route -n delete -net 173.36 -interface "${CISCO_INTERFACE}"
sudo route -n delete -net 173.37 -interface "${CISCO_INTERFACE}"
sudo route -n delete -net 173.38 -interface "${CISCO_INTERFACE}"
sudo route -n delete -net 173.39 -interface "${CISCO_INTERFACE}"
sudo route -n delete -net 171.68 -interface "${CISCO_INTERFACE}"
sudo route -n delete -net 171.69 -interface "${CISCO_INTERFACE}"
sudo route -n delete -net 171.70 -interface "${CISCO_INTERFACE}"
sudo route -n delete -net 171.71 -interface "${CISCO_INTERFACE}"
sudo route -n delete -net 161.44 -interface "${CISCO_INTERFACE}"
sudo route -n delete -net 161.144 -interface "${CISCO_INTERFACE}"
sudo route -n delete -net 114.29 -interface "${CISCO_INTERFACE}"
#
sudo route -n delete -net 10.1.0.0/16  -interface "${CISCO_INTERFACE}"
sudo route -n delete -net 10.2.0.0/15  -interface "${CISCO_INTERFACE}"
sudo route -n delete -net 10.4.0.0/14  -interface "${CISCO_INTERFACE}"
sudo route -n delete -net 10.8.0.0/13   -interface "${CISCO_INTERFACE}"
sudo route -n delete -net 10.16.0.0/12  -interface "${CISCO_INTERFACE}"
sudo route -n delete -net 10.32.0.0/13  -interface "${CISCO_INTERFACE}"
sudo route -n delete -net 10.252 -interface "${CISCO_INTERFACE}"
sudo route -n delete -net 10.230 -interface "${CISCO_INTERFACE}"
sudo route -n delete -net 10.226.0.0/16 -interface "${CISCO_INTERFACE}"

sudo route -n delete -net 10.40.0.0/13 -interface "${CISCO_INTERFACE}"
sudo route -n delete -net 10.48.0.0/12 -interface "${CISCO_INTERFACE}"
sudo route -n delete -net 10.64.0.0/10 -interface "${CISCO_INTERFACE}"
sudo route -n delete -net 10.83.6.32/27 -interface "${CISCO_INTERFACE}"
sudo route -n delete -net 10.128.0.0/10 -interface "${CISCO_INTERFACE}"
sudo route -n delete -net 10.192.0.0/11 -interface "${CISCO_INTERFACE}"
sudo route -n delete -net 10.224.0.0/32 -interface "${CISCO_INTERFACE}"
sudo route -n delete -net 18.211.0.0/14  -interface "${CISCO_INTERFACE}"
#
sudo route -n delete -net 23.96.0.0/13 -interface "${CISCO_INTERFACE}"
sudo route -n delete -net 52.96.0.0/16 -interface "${CISCO_INTERFACE}"


sudo route -n delete -net 40.64.0.0/10 -interface "${CISCO_INTERFACE}"

sudo route -n delete -net 64.100.0.0/14 -interface "${CISCO_INTERFACE}"
sudo route -n delete -net 64.104.0.0/16 -interface "${CISCO_INTERFACE}"
sudo route -n delete -net 64.112.0.0/12 -interface "${CISCO_INTERFACE}"
sudo route -n delete -net 64.128.0.0/10 -interface "${CISCO_INTERFACE}"
sudo route -n delete -net 64.192.0.0/11 -interface "${CISCO_INTERFACE}"
sudo route -n delete -net 64.224.0.0/32 -interface "${CISCO_INTERFACE}"
sudo route -n delete -net 66.114.0.0/12 -interface "${CISCO_INTERFACE}"

sudo route -n delete -net 69.162.64.0/18 -interface "${CISCO_INTERFACE}"

sudo route -n delete -net 72.163 -interface "${CISCO_INTERFACE}"

sudo route -n delete -net 104.208.0.0/13 -interface "${CISCO_INTERFACE}"

sudo route -n delete -net 172.16 -interface "${CISCO_INTERFACE}"
sudo route -n delete -net 172.18 -interface "${CISCO_INTERFACE}"
sudo route -n delete -net 192.168.111 -interface "${CISCO_INTERFACE}"
sudo route -n delete -net 199.91.0.0/16 -interface "${CISCO_INTERFACE}"
sudo route -n delete -net 13.59.86/22 -interface "${CISCO_INTERFACE}"
sudo route -n delete -net 13.59.223/24 -interface "${CISCO_INTERFACE}"
sudo route -n delete -net 13.56.118.0/24 -interface "${CISCO_INTERFACE}"
sudo route -n delete -net 3.16  -interface "${CISCO_INTERFACE}"
sudo route -n delete -net 207.182.170/16 -interface "${CISCO_INTERFACE}"

sudo route -n delete -net 217.70.184.38/31 -interface "${CISCO_INTERFACE}"
# for aws cloud instances

  sudo route -n delete -net 52.0.0.0/6 -interface "${CISCO_INTERFACE}"
  #
  # Set DNS for Cisco networks
  #
  sudo networksetup -setdnsservers "$HOME_INTERFACE" "${HOME_DNS}"
  sudo killall -HUP mDNSResponder;sudo killall mDNSResponderHelper;sudo dscacheutil -flushcache
}

#
# This assumes that the CVO router is set a default route ( "${CISCO_INTERFACE}")but it is second to the wired ethernet connection "${CISCO_INTERFACE}"
#
# Enable ip forwarding

#
# Will populate the NEW array with a list of network interfaces that DO NOT include the
# home interface nor the cisco interface
#
interface_list(){
  SAVEIFS=$IFS
  IFS=$(echo -en "\n\b")
  LIST=$(networksetup -listnetworkserviceorder | cut -d')' -f2 | sed '/^$/d' | sed '1d' | sed -e 's/^[ \t]*//')


  for i in ${LIST[@]}
  do
    if [ "$i" = "$HOME_INTERFACE_NAME" ] ; then
      true
    elif [ "$i" = "$CISCO_INTERFACE_NAME" ] ; then
      true
    else
        NEW+=("$i")
    fi
  done
  IFS=$SAVEIFS

}




cisco_only() {
  interface_list
  networksetup -ordernetworkservices "$CISCO_INTERFACE_NAME" "$HOME_INTERFACE_NAME" "${NEW[@]}"
}

home_only() {
  interface_list
  networksetup -ordernetworkservices "$HOME_INTERFACE_NAME" "$CISCO_INTERFACE_NAME" "${NEW[@]}"
}

  case "$1" in
  'cisco-only')
  echo "Going Full Cisco mode:  ${CISCO_INTERFACE}"
  delete_route
  cisco_only
  ;;
  'home-only')
  echo "Going Full Home Mode"" ${HOME_INTERFACE}"
  delete_route
  home_only
  ;;
  'start')
  echo "Creating Static Routes on interface "${CISCO_INTERFACE}""
  create_route
  ;;
  'stop')
  echo "Deleteing Static Routes"
  delete_route
  ;;
  'restart')
  echo "Usage: $0 [start|stop]"
  delete_route
  create_route
  ;;
  esac
