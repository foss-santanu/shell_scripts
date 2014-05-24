##
## A backup script to copy user environment to new Ubuntu installation
## Inspired by AskUbuntu discussion:
## Best way to backup all settings, list of installed packages, tweaks, etc?
## Ref:
## http://askubuntu.com/questions/9135/best-way-to-backup-all-settings-list-of-installed-packages-tweaks-etc
## The script is no-way self contained and is very much tied to my host system.
## Therefore it may give error is some other host OS. Make necessary changes in the script
## for such situations. This script is only to save the user from typing lots of commands in SHELL.
##

backup_root="/host/backup"
restore_root=""

if [ $# -eq 0 ]; then
    echo "Usage: backup --backup|--install --broot=<backup_dir> [--iroot=<restore_root> <archive_name>]"
    exit 0
fi

if [ "$1" == "--backup" ]; then
    ## Take backup of relevant items
    if test -n "$2" && "$2" =~ "--broot=.*"; then
        backup_root={$2:8}
    fi
    backup_dir=$backup_root/os_config_backup
    if [ ! -d $backup_dir ]; then
        mkdir -p $backup_dir
    fi
    sudo dpkg --get-selections > $backup_dir/Package.list
    sudo cp -R -P /etc/apt/sources.list* $backup_dir
    sudo apt-key exportall > $backup_dir/Repo.keys
    if [ ! -d $backup_dir/home ]; then
        mkdir -p $backup_dir/home
    fi
    rsync -a --progress /home/`whoami` $backup_dir/home
    sudo rsync -a --progress /opt $backup_dir
    if [ ! -d $backup_dir/etc ]; then
        mkdir -p $backup_dir/etc
    fi
    sudo cp -P /etc/fstab $backup_dir/etc/.
    sudo cp -P /etc/environment $backup_dir/etc/.
    if [ ! -d $backup_dir/etc/udev/rules.d ]; then
        mkdir -p $backup_dir/etc/udev/rules.d
    fi
    sudo cp -P  /etc/udev/rules.d/51-android.rules $backup_dir/etc/udev/rules.d/.
    sudo cp -P /etc/udev/rules.d/99-usb-disks.rules $backup_dir/etc/udev/rules.d/.

    ## Compressing the backup dir
    cwd=`pwd`
    cd $backup_root
    tar cvpzf os_config_backup_`date +%m%d%Y`.tar.gz os_config_backup
    rm -R os_config_backup
    cd $cwd
elif [ "$1" == "--install" ]; then
    ##  Reinstall now
    if test -n "$2" && "$2" =~ "--broot=.*"; then
        backup_root={$2:8}
        shift
    fi
    if test -n "$2" && "$2" =~ "--iroot=.*"; then
        $restore_root={$3:8}
        shift
    fi

    ## Extracting the backup archive
    cwd=`pwd`
    archive_name="os_config_backup.tar.gz"
    cd $backup_root
    if [ -n "$2" ]; then
        archive_name="$2"
    fi
    tar xvpzf $archive_name
    cd $cwd

    backup_dir=$backup_root/os_config_backup
    sudo cp -b --suffix=bak -P $backup_dir/etc/fstab $restore_root/etc/.
    sudo cp -b --suffix=bak -P $backup_dir/etc/environment $restore_root/etc/.
    sudo cp -b --suffix=bak -P $backup_dir/etc/udev/rules.d/51-android.rules $restore_root/etc/udev/rules.d/.
    sudo cp -b --suffix=bak -P $backup_dir/etc/udev/rules.d/99-usb-disks.rules $restore_root/etc/udev/rules.d/.
    rsync -a --progress $backup_dir/home/`whoami` $restore_root/home/`whoami`
    sudo rsync -a --progress $backup_dir/opt $restore_root/opt
    if [ "$restore_root" == "" ]; then
        sudo apt-key add $backup_dir/Repo.keys
    fi
    sudo cp -R -b --suffix=bak -P $backup_dir/sources.list* $restore_root/etc/apt/
    if [ "$restore_root" == "" ]; then
        sudo apt-get update
        sudo apt-get install dselect
        sudo dpkg --set-selections < $backup_dir/Package.list
        sudo apt-get dselect-upgrade -y
    fi
fi
