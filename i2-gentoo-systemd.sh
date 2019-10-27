##INSTALL GENTOO BIOS SYSTEMD



#wget http://ditfiles.gentoo.org/snapshots/portage-latest.tar.b2z
#nano -w /etc/portage/make.conf
#mirrorselect -i -o >> /etc/portage/make.conf
#mkdir -p /mnt/gentoo/etc/portage/repos.conf
#cp /mnt/gentoo/usr/share/portage/config/repos.conf /mnt/gentoo/etc/portage/repos.conf/gentoo.conf
#cp -L /etc/resolv.conf /mnt/gentoo/etc/
#


#env-update && source /etc/profile && export PS1="(chroot) ${PS1}"
#emerge-webrsync
#emerge --sync --quiet
#eselect profile list
#eselect profile set #20
#eselect profile list
#emerge --ask --verbose --update --deep --newuse @world
#emerge-webrsync
#emerge --sync --quiet
#etc-update
#emerge --ask --verbose --update --deep --newuse @world
#localectl
#echo "America/Monterrey" > /etc/timezone
#emerge --config sys-libs/timezone-data
#nano -w /etc/locale.gen
#locale-gen
#eselect locale list
#eselect locale set #7
#env-update && source /etc/profile && export PS1="(chroot) ${PS1}"
#etc-update
#nano -w /etc/fstab
#emerge --ask sys-kernel/gentoo-sources
#ls -l /usr/src/linux

###########################################
##COPIAR LA CONFIGURACION DEL KERNEL MANUAL
##cp .config /usr/src/linux/
##
###make menuconfig
###make -j3
###make modules_install
###make install
###########################################

###########################################
##USANDO GENKERNEL-NEXT Editar genkernel.conf y en udev="yes"
#emerge --ask sys-kernel/genkernel-next
#genkernel --no-btrfs --menuconfig all
#genkernel --no-btrfs --kernel-config=/path/.config --menuconfig all
###########################################

#hostnamectl set-hostname river
########nano -w /etc/conf.d/hostname
#nano -w /etc/hosts
#passwd
#nano -w /etc/conf.d/keymaps
#nano -w /etc/conf.d/hwclock
#emerge --ask app-admin/sysklogd
#rc-update add sysklogd default
#emerge -a gentoolkit portage-utils eix nmon
#eix-sync
#emerge --ask sys-apps/mlocate
#emerge --ask sys-fs/btrfs-progs
#emerge --ask net-wireless/wpa_supplicant
#emerge --ask net-misc/dhcpcd
#emerge --ask dev-vcs/git
####CHECAR SI ES NECESARIO /etc/portage/make.conf (python -ldap -bluetooh)
#emerge -avuDN @world
#emerge -av xorg-drivers twm xterm xorg-server
####### SI APARECE ERROR, AGREGAR EN
#nano -w /etc/portage/package.use/custom
#emerge --ask sys-boot/grub:2
#grub-install /dev/sda
#grub-mkconfig -o /boot/grub/grub.cfg
#useradd -m -G users,wheel,audio,video,usb,portage -s /bin/bash avi
#passwd avi
#umount -R /mnt/gentoo/
#swapoff -a
#reboot

#emerge -av gdm gnome-shell
####### SI APARECE ERROR, AGREGAR EN
#nano -w /etc/portage/package.use/custom
#eix gdm
#eix gnome-shell
#systemctl get-default
#systemctl start gdm
#systemctl enable gdm

#genkernel --save-config
#history -a
