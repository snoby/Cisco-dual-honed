# Cisco-dual-honed
A simple bash script for MacOS to allow the user to run on both his home wired connection and also on a wired connection to his Cisco CVO device.

## Must set variables

This is not a complex script.  You must set which ethernet interface is connected to the Cisco network.  This is done with the varialbe `CISCO_INTERFACE`.  Currently it is set with my default value of en5.
The other variable is the home DNS server.  This is so when you turn on and off we can switch back to the right DNS server

* CISCO_INTERFACE
* HOME_DNS

You must also have your home network interface, the one that you want to be the default route as the main network interface ( top one in the list ) in the network panel in the Settings menu.

## What it does

 This a script to setup a dual honed MAC to connect to a public internet available network (Home Network)
 and to connect to an ethernet connected private network.  (VPN network).  This is through a second router
 that has access to the private network.

 TLDR; - If you have two routers, one for the public internet and another to a private network to a corporate VPN.
    Basically I just add a bunch of specific routes and change the main DNS server to be the corporate LAN DNS server
    because it can resolve public IP addresses as well as the private ones.

 en5 - is the private network


