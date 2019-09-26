#mount -o remount,size=1G /run/archiso/cowspace
#sudo dd bs=4M if=archlinux.iso of=/dev/sdX status=progress && sync
#
#loadkeys es
#wifi-menu
#gdisk /dev/sda
#introduce  x --> z -->  y --->y
#fdisk /dev/sda
# sda1 boot ef02 (cgdisk)
# sda2 root
# sda3 home
# sda4 swap
#mkfs.fat -F32 /dev/sda1
#mkfs.btrfs /dev/sda2 -f
#mkfs.btrfs /dev/sda3 -f
#mkswap /dev/sda4
#swapon /dev/sda4
#
#mount /dev/sda2 /mnt
#mkdir /mnt/boot
#mkdir /mnt/home
#mount /dev/sda1 /mnt/boot
#mount /dev/sda3 /mnt/home
#pacstrap -i /mnt base base-devel
#genfstab -U -p /mnt >> /mnt/etc/fstab
#arch-chroot /mnt
#
#systemctl enable fstrim.timer
#pacman -Sy
#passwd
#useradd -m -g users -G rfkill,wheel,network,lp,storage,power,video,audio -s /bin/bash abdias
#passwd abdias
#ln -s /usr/share/zoneinfo/America/Monterrey > /etc/localtime
#echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen
#echo 'LANG=en_US.UTF-8' > /etc/locale.conf
#locale-gen
#echo 'KEYMAP=la-latin1' > /etc/vconsole.conf
#echo river > /etc/hostname
#hwclock --systohc --utc
#timedatectl set-timezone "America/Monterrey"
#echo -e '127.0.0.1\tlocalhost\n::1\tlocalhost\n127.0.1.1\triver.linux\triver\n' > /etc/hosts
#mkinitcpio -p linux
#
#
#########pacman -S intel-ucode --noconfirm --needed
#########echo -e "initrd /intel-ucode.img\r\ninitrd /initramfs-linux.img" >> /boot/loader/entries/arch.conf

#
#pacman -S grub --noconfirm
#grub-install --target=i386-pc --recheck /dev/sda
#
#grub-mkconfig -o /boot/grub/grub.cfg
#
#pacman -S grub
#grub-install /dev/sda
#pacman -S dhcpcd --noconfirm
#systemctl enable dhcpcd
#
#
#git clone https://aur.archlinux.org/yay.git
#cd yay
#makepkg -si
#yay xlogin-git
#sudo systemctl enable xlogin@abdias
#sudo pacman -S xf86-video-intel xdg-usr-dirs termite
#sudo pacman -S wpa_supplicant wireless_tools networkmanager
#sudo systemctl enable NetworkManager.service
#sudo systemctl start NetworkManager.service
#nmcli device wifi list
#nmcli device wifi connect RIVERA password RIVERA901
#sudo pacman -S noto-fonts ttf-ubuntu-font-family ttf-dejavu ttf-freefont ttf-liberation ttf-droid ttf-inconsolata ttf-roboto terminus-font ttf-font-awesome
#sudo pacman -S gst-plugins-good gst-plugins-bad gst-plugins-base gst-plugins-ugly  gstreamer  --noconfirm --needed
#sudo pacman -S alsa-utils alsa-plugins alsa-lib alsa-firmware --noconfirm --needed
#sudo pacman -S pulseaudio pulseaudio-alsa pavucontrol  --noconfirm --needed
#sudo pacman -S --noconfirm --needed unace unrar zip unzip sharutils  uudeview  arj cabextract file-roller
#sudo systemctl disable avahi-daemon.service
#sudo paccache -d
####
#sudo pacman -S i3-gaps xorg-server xorg-xinit
# add exec i3 to .xinitrc
