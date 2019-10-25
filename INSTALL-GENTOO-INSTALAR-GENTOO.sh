#Boot cd & on the shell type        gentoo
#BORRAR & CREAR PARTICIONES
#gdisk /dev/sda
#mkfs.ext2 /dev/sda1 #boot
#mkfs.btrfs /dev/sda2   #root
#mkfs.btrfs /dev/sda3    #home
#mkswap /dev/sda4
#swapon /dev/sda4
#mount /dev/sda2 /mnt/gentoo
#mkdir /mnt/gentoo/boot
#mkdir /mnt/gentoo/home
mount /dev/sda1 /mnt/gentoo/boot
mount /dev/sda3 /mnt/gentoo/home
cd /mnt/gentoo
links https://www.gentoo.org/downloads/
tar xpvf stage3-*.tar.bz2 --xattrs --numeric-owner
rm stage3-*.tar.bz2
wget http://distfiles.gentoo.org/releases/amd64/autobuilds/20191023T214502Z/stage3-amd64-20191023T214502Z.tar.xz
cp -L /etc/resolv.conf /mnt/gentoo/etc/resolv.conf
mkdir --parents /mnt/gentoo/etc/portage/repos.conf
cp /mnt/gentoo/usr/share/portage/config/repos.conf /mnt/gentoo/etc/portage/repos.conf/gentoo.conf
root #mount --types proc /proc /mnt/gentoo/proc
root #mount --rbind /sys /mnt/gentoo/sys
root #mount --make-rslave /mnt/gentoo/sys
root #mount --rbind /dev /mnt/gentoo/dev
root #mount --make-rslave /mnt/gen
mkdir /mnt/gentoo/usr/portage
root #chroot /mnt/gentoo /bin/bash
root #source /etc/profile
root #export PS1="(chroot) ${PS1}"
nano -w /etc/portage/make.conf
CFLAGS="-march=native -O2 -pipe"
MAKEOPTS="-j3"
configuración básica  de USE con X y ALSA:
USE="bindist mmx sse sse2 X alsa"
configurar USE: (para GNOME y/o XFCE4 con SYSTEMD)
USE=”gtk gnome -qt4 -kde -qt5 alsa cdr bindist mmx sse sse2″
USE=“gtk gnome -qt4 -kde dvd dbus X alsa cdr bindist mmx sse sse2 systemd”
configurar USE: (para KDE)
USE=“-gtk -gnome qt4 kde dvd X alsa cdr bindist mmx sse sse2”
ACCEPT_LICENSE="*"
LINGUAS="es es_ES"
L10N="es es-ES"
##############
nano -w /etc/portage/make.conf
CFLAGS=”-march=native -O2 -pipe”
CXXFLAGS=”${CFLAGS}”
CHOST=”x86_64-pc-linux-gnu”
PORTDIR=”/usr/portage”
DISTDIR=”${PORTDIR}/distfiles”
PKGDIR=”${PORTDIR}/packages”
ACCEPT_LICENSE=”*”
MAKEOPTS=”-j9"
AUTOCLEAN=”yes”
CLEAN_DELAY=2
EMERGE_DEFAULT_OPTS=” — jobs=4 — keep-going — nospinner — quiet-build — with-bdeps=y”
ALSA_CARDS=”hda-intel”
ALSA_PCM_PLUGINS=”*”
VIDEO_CARDS=”nvidia”
LINGUAS=”es es_ES”
L10N=”es es-ES”
USE_ENABLED=”pulseaudio ”
USE_DISABLED=”-gnome -gtk -qt3support -qt4"
USE=”${USE_ENABLED} ${USE_DISABLED}”
#################
mirrorselect -i -o >> /mnt/gentoo/etc/portage/make.conf
emerge-webrsync
emerge --sync --quiet
eselect profile list
###Al seleccionar el perfil se agregan USE a make.defaults del perfil y se combinan con make.conf
eselect profile set 2
emerge --info | grep ^USE
emerge --ask --verbose --update --deep --newuse @world
#### Cuando se cambie de perfil sudo emerge -uaDN --with-bdeps=y world
#Si hay errores  syncronizar y combinar
env-update && source /etc/profile && export PS1="(chroot) $PS1"
##################
echo "America/Monterrey" > /etc/timezone
emerge --config sys-libs/timezone-data
nano -w /etc/locale.gen
en_US ISO-8859-1
en_US.UTF-8 UTF-8
es_ES ISO-8859-1
es_ES.UTF-8 UTF-8
locale-gen
eselect locale list
eselect locale set 9
env-update && source /etc/profile && export PS1="(chroot) $PS1"
########KERNEL
root #emerge --ask sys-kernel/genkernel
root #nano -w /etc/fstab
/dev/sda2 /boot	ext2	defaults	0 2
root #genkernel all
root #ls /boot/kernel* /boot/initramfs*

root #emerge --ask sys-kernel/linux-firmware
root #nano -w /etc/fstab
/dev/sda10      /boot      ext2        noatime                 0 0
/dev/sda3        none        swap     defaults                  0 0
/dev/sda11         /            ext4      noatime                  0 1
/dev/sda12      /home    ext4      noatime                  0 2

root #blkid
root #nano -w /etc/conf.d/hostname

#####root #nano -w /etc/conf.d/net
#####config_eth0="dhcp"
#####root #cd /etc/init.d
#####root #ln -s net.lo net.eth0
#####root #rc-update add net.eth0 default
nano -w /etc/conf.d/keymaps
keymap="es"

root #nano -w /etc/hosts
127.0.0.1     avi.river avi localhost
root #passwd
root #nano -w /etc/conf.d/hwclock
root #emerge --ask app-admin/sysklogd
root #rc-update add sysklogd default
root #emerge --ask sys-apps/mlocate
emerge --ask sys-fs/btrfs-progs
root #emerge --ask net-misc/dhcpcd
root #emerge --ask net-wireless/iw net-wireless/wpa_supplicant

root #emerge --ask sys-boot/grub:2
root #grub-install /dev/sda
root #grub-mkconfig -o /boot/grub/grub.cfg
useradd -m -G users,wheel,audio,video,usb,portage -s /bin/bash pepito
passwd avi
root #useradd -m -G users,wheel,audio -s /bin/bash avi

cdimage ~#cd
cdimage ~#umount -l /mnt/gentoo/dev{/shm,/pts,}
cdimage ~#umount -R /mnt/gentoo
cdimage ~#reboot
root #exit
