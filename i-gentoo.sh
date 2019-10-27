##INSTALL GENTOO BIOS SYSTEMD
#source /etc/profile
#export PS1="(chroot) ${PS1}"
#nano -w /etc/portage/make.conf
#mirrorselect -i -o >> /etc/portage/make.conf
#export PS1="(chroot) ${PS1}"
#emerge-webrsync
#emerge --sync --quiet
#nano -w /etc/portage/make.conf
#eselect profile list
#eselect profile set #20
#eselect profile list
#emerge --info | grep ^USE
#nano -w /etc/portage/make.conf
#emerge --ask --verbose --update --deep --newuse @world
#emerge-webrsync
#emerge --sync --quiet
#emerge --info | grep ^USE
#emerge --ask --verbose --update --deep --newuse @world
#etc-update
#emerge --ask --verbose --update --deep --newuse @world
#echo "America/Monterrey" > /etc/timezone
#emerge --config sys-libs/timezone-data
#nano -w /etc/locale.gen
#locale-gen
#eselect locale list
#eselect locale set #7
#env-update && source /etc/profile && export PS1="(chroot) ${PS1}"
#emerge --ask sys-kernel/genkernel-next
#etc-update
#nano -w /etc/fstab
#emerge --ask sys-kernel/gentoo-sources
#ls -l /usr/src/linux
#genkernel --no-btrfs --menuconfig all
#nano -w /etc/conf.d/hostname
#nano -w /etc/hosts
#passwd
#nano -w /etc/conf.d/keymaps
#nano -w /etc/conf.d/hwclock
#emerge --ask app-admin/sysklogd
#rc-update add sysklogd default
#emerge --ask sys-apps/mlocate
#emerge --ask sys-fs/btrfs-progs
#emerge --ask net-wireless/wpa_supplicant
#emerge --ask net-misc/dhcpcd
#emerge --ask dev-vcs/git
#emerge --ask sys-boot/grub:2
#grub-install /dev/sda
#grub-mkconfig -o /boot/grub/grub.cfg
#useradd -m -G users,wheel,audio,video,usb,portage -s /bin/bash avi
#passwd avi
#umount -R /mnt/gentoo/
#swapoff -a
#reboot
#genkernel --save-config
#emerge --ask dev-vcs/git
#history -a
