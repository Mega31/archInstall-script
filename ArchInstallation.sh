

#!/bin/bash
echo"Arch Installation"

pacstrap /mnt base linux linux-lts linux-firmware i3  nvidia bbswitch codeblocks intellij-idea-community-edition eclipse-jee rofi thunar networkmanager ntfs-3g lightdm lightdm-webkit2-greeter firefox chromium telegram-desktop git sudo network-manager-applet cpupower lib32-mesa xf86-video-intel acpi wpa_supplicant  dialog  xorg xorg-server-utils  xorg-xinit   jdk11-openjdk 	 gparted lxappearance feh neofetch polkit-gnome git
echo"genfstab"
genfstab -U /mnt >> /mnt/etc/fstab

echo"arch-chow root"

arch-chroot /mnt 

git clone https://github.com/Mega31/I3Conf.git 

ln -sf /usr/share/zoneinfo/India/Kolkata /etc/localtime

hwclock --systohc
  
sed -i 's/#en_US.UTF-8/en_US.UTF-8/g' /etc/locale.gen

locale-gen

echo LANG=en_US.UTF-8 > /etc/locale.conf
export LANG=en_US.UTF-8

echo arch >> /etc/hostname

echo 127.0.0.1   localhost.localdomain   localhost >>/etc/hosts
echo ::1         localhost.localdomain   localhost>>/etc/hosts
127.0.1.1   arch.localdomain        arch >>/etc/hosts

echo blacklist nvidia >>/usr/lib/modprobe.d/nvidia-xrun.conf
echo blacklist nvidia-drm >>/usr/lib/modprobe.d/nvidia-xrun.conf
echo blacklist nvidia-modeset >>/usr/lib/modprobe.d/nvidia-xrun.conf
echo blacklist nvidia-uvm >>/usr/lib/modprobe.d/nvidia-xrun.conf
echo blacklist nouveau >>/usr/lib/modprobe.d/nvidia-xrun.conf



read -p "root password " pass
passwd 
$pass

read -p "confirm password " cpass
$cpass

read -p "Enter Username"usr
useradd -m -G wheel -s /bin/bash $usr
git clone https://github.com/Mega31/I3Conf.git  /home/$usr/.config/i3/
git clone https://github.com/Mega31/intel--config-arch.git /etc/X11/xorg.conf.d/
read -p "sudoer password" spass
passwd $usr
$spass
read -p "sudoer confimed password"scpass
$scpass


echo"now you have to uncomment multillib"
nano /etc/pacman.conf


echo "doing pacman -syu"

pacman -Syu dosfstools grub efibootmgr intel-ucode 
mkdir /boot/efi
read -p "enter boot partion"partion 
echo "mounting boot to efi"
mount /dev/$partion /boot/efi

echo"installing grub"
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=grub --recheck
grub-mkconfig -o boot/grub/grub.cfg

echo" "
echo"Instalation finished"
