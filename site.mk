##	gluon site.mk makefile

##	GLUON_SITE_PACKAGES
#		specify gluon/openwrt packages to include here
#		The gluon-mesh-batman-adv-* package must come first because of the dependency resolution

GLUON_SITE_PACKAGES := \
	gluon-mesh-batman-adv-14 \
	gluon-alfred \
	gluon-respondd \
	gluon-neighbour-info \
	gluon-autoupdater \
	gluon-config-mode-autoupdater \
	gluon-config-mode-contact-info \
	gluon-config-mode-core \
	gluon-config-mode-geo-location \
	gluon-config-mode-hostname \
	gluon-config-mode-tunneldigger \
	gluon-ebtables-filter-multicast \
	gluon-ebtables-filter-ra-dhcp \
	gluon-luci-admin \
	gluon-luci-autoupdater \
	gluon-luci-portconfig \
	gluon-luci-private-wifi \
	gluon-luci-wifi-config \
	gluon-luci-node-role \
	gluon-next-node \
	gluon-mesh-vpn-tunneldigger \
	gluon-tunneldigger-watchdog \
	gluon-radvd \
	gluon-setup-mode \
	gluon-status-page \
	gluon-migrate-vpn \
	gluon-txpower-fix \
	haveged \
	iptables \
	iwinfo

##	DEFAULT_GLUON_RELEASE
#		version string to use for images
#		gluon relies on
#			opkg compare-versions "$1" '>>' "$2"
#		to decide if a version is newer or not.

#DEFAULT_GLUON_RELEASE := 0.6+exp$(shell date '+%Y%m%d')
# [autoupdater_branch]-[gluon_branch]-[gluon_commit]-[mesh-vpn]-[packages_commit]-[counter]
# [gluon_commit] = https://github.com/freifunk-gluon/gluon/commits/v2016.1.x
# [packages_commit] = https://github.com/ffrl/ffrl-packages/commits/Branch_v2016.1.x
DEFAULT_GLUON_RELEASE := exp-2016.1.x-14ccbd2-l2tp-510012d-0

##	GLUON_RELEASE
#		call make with custom GLUON_RELEASE flag, to use your own release version scheme.
#		e.g.:
#			$ make images GLUON_RELEASE=23.42+5
#		would generate images named like this:
#			gluon-ff%site_code%-23.42+5-%router_model%.bin

# Allow overriding the release number from the command line
GLUON_RELEASE ?= $(DEFAULT_GLUON_RELEASE)

# Default priority for updates.
GLUON_PRIORITY ?= 0

# Languages to include
GLUON_LANGS ?= en de da
