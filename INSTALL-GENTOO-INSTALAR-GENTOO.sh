#Boot cd & on the shell type        gentoo
#BORRAR & CREAR PARTICIONES
#gdisk /dev/sda
#mkfs.ext2 /dev/sda1
#mkfs.btrfs /dev/sda2
#mkfs.btrfs /dev/sda3
#mkswap /dev/sda4
#swapon /dev/sda4
#mount /dev/sda2 /mnt/gentoo
#mkdir /mnt/gentoo/boot
#mkdir /mnt/gentoo/home
cd /mnt/gentoo
links https://www.gentoo.org/downloads/
tar xpvf stage3-*.tar.bz2 --xattrs-include='*.*' --numeric-owner
wget http://distfiles.gentoo.org/releases/amd64/autobuilds/20191023T214502Z/stage3-amd64-20191023T214502Z.tar.xz
nano -w /mnt/gentoo/etc/portage/make.conf
CFLAGS="-march=native -O2 -pipe"
MAKEOPTS="-j3"
configuración básica  de USE con X y ALSA:
USE="bindist mmx sse sse2 X alsa"
configurar USE: (para GNOME y/o XFCE4 con SYSTEMD)
USE=“gtk gnome -qt4 -kde dvd dbus X alsa cdr bindist mmx sse sse2 systemd”
configurar USE: (para KDE)
USE=“-gtk -gnome qt4 kde dvd X alsa cdr bindist mmx sse sse2”
ACCEPT_LICENSE="*"
LINGUAS="es es_ES"
L10N="es es-ES"
cp -L /etc/resolv.conf /mnt/gentoo/etc/resolv.conf
