#!/bin/bash
#Made by Gal Newman 

#global definitions


#paths definition block
hostlog=/home/$SUDO_USER/.ssh/hostlog


#host array
mapfile -t known_hosts < $hostlog


#menues definition block
menu(){
    echo""
    choice=0
    logd="choice"
    while [ "$choice" -ne 6 ]; 
    do
      echo "Press 1 to add a user"
      echo "Press 2 to delete a user"
      echo "Press 3 to lock a user"
      echo "Press 4 to unlock a user"
      echo "Press 5 to give a user script run permissions"
      echo "Press 6 to return to main menu"
      read -p "Enter your choice: " choice

      case $choice in

          1)read -p $'input username to add\n' name
                if ! append_check; then
                  adduser $name
                else
                    echo "name exists"
                fi
                logman
                ;;
          2)read -p $'input username to delete\n' name 
                if  append_check;then
                 userdel -r $name
                else
                    echo "name doesnt exists"
                fi
                logman
                ;;
          3)read -p $'input username to lock\n' name
                usermod -L $name
                logman
                ;;  
          4)read -p 'input username to unlock\n' name
                usermod -U $name
                logman
                ;;
          5)read -p $'input username for script permission\n' name
                usermod -aG script_group $name;logman;;
          6)echo "Main menu"
                mainmenu=0;clear;return ;;
          *) echo "Invalid option. Please try again.";;
      esac
  done
}

backup(){
      echo ""
      echo -e "Current directory:\n$PWD"
      echo -e "Content of current directory:\n"
      ls
      echo ""
      bckp=0
      logd="bckp"
      while [ "$bckp" -ne 5 ];
      do
        echo -e "Welcome to Backup Master"
        echo  "Press 1 to set a file to backup" 
        echo  "Press 2 to zip selected file"
        echo  "Press 3 to archive dir"
        echo  "Press 4 to backup"
        echo  "Press 5 return to main menu"
        read -p $'please choose an option:\n' bckp

        case $bckp in 
            1)read -p $'Input full directory\n' flnm1
              echo "Target set to: $flnm1";logman;;
            2)echo "Zipping file $flnm1"
                  gzip -k $flnm1;logman;;
            3)read -p "Please state directory to archive" dir1
              read -p "Please state archive name" arcnme
                  echo "Archiving Please wait"
                      tar -cvf $dir1 -C $arcnme;logman;;
            4)echo "Backupping Target"
                  cp $dir1 /backup;logman;;
    
            5)echo "returning to main menu"
                  mainmenu=0;clear;return ;;
            *) echo "Invalid option. Please try again.";;
  
        esac
    done  
}
#File manipulation menu block
filemanip(){
         echo ""
         echo -e "Current directory:\n$PWD"
         echo -e "Content of current directory:\n"
         ls
         echo ""
         filema=0
         logd="filema"
         while [ "$filema" -ne 5 ];
         do
           echo -e "Welcome to file manipulation menu"
           echo "Press 1 to create file"
           echo "Press 2 to edit file"
           echo "Press 3 to make file executable"
           echo "Press 4 to print file"
           echo "Press 5 to return to main menu"
           read -p $'please choose an option:\n' filema
         
           case $filema in 
           1) read -p $'Insert filename to create\nwith or without full path\n' fname
                  touch "$fname";echo "creating file $fname";logman;;
           2) read -p $'Insert filename to edit\nwith or without full path' fname
                  nano "$fname";echo "editing file $fname";logman;;
           3) read -p $'Insert filename to make executable\n' fname
                  chmod +x "$fname";echo "$fname is now executable";logman;;  
           4) read -p $'Insert filename to display its content\n' fname
                  cat "$fname";logman;;
           5) echo -e "returning main menu"
                  mainmenu=0;clear;return ;;
                  
           *) echo "Invalid option. Please try again."
                  ;;
         
           esac
        done
}
#General Commands menu block
generalcommandsmenu(){
                   echo ""
                   gcm=0
                   logd="gcm"
                   while [ "$gcm" -ne 6 ];
                   do
                     echo -e "welcome to General Commands Menu"
                     echo "Press 1 to refresh update files"
                     echo "Press 2 to upgrade system"
                     echo "Press 3 to remove unneeded packages"
                     echo "Press 4 to remove specific package"
                     echo "Press 5 to install specific package"
                     echo "Press 6 to return to main menu"
                     read -p $'please choose an option:\n' gcm
                     case $gcm in
                         1) echo "...Updating"
                                 apt update;logman;; 
                         2) echo "...Upgrading"
                                 apt upgrade;logman;;
                         3) echo "...cleaning packages"
                                 apt autoremove;logman;;
                         4) read -p "Input package name for removal" pack1
                                 apt purge $pack1;logman;;
                         5) read -p "Input a package to install " pack2
                                 apt install $pack2;logman;;
                         6) echo -e "Returning to main menu"
                                 mainmenu=0;clear;return ;;
                         *) echo "Invalid option. Please try again.";;
                     esac
                   done
}                  
#Monitoring menu block
monitor(){
       echo""
       mon1=0
       logd="mon1"
       while [ "$mon1" -ne 6 ];
       do
         echo -e "Welcome to Monitoring menu"
         echo "Press 1 to view processes"
         echo "Press 2 to view cpu/mem usage"
         echo "Press 3 to view the last 20 lines of syslog"
         echo "Press 4 to view the last 20 lines of journalctl"
         echo "Press 5 to view kernel log warnings"
         echo "Press 6 to return to main menu"
         read -p $'Please choose an option:\n' mon1
         case $mon1 in
             1) ps aux;;
             2) htop;;
             3) tail -n 20 /var/log/syslog;;
             4) journalctl -n 20;;
             5) dmesg --level=err,warn,crit,alert,emerg;;
             6) echo -e "Returning to main menu"
                    mainmenu=0;clear;return ;;
             *) echo "Invalid option. Please try again.";;
         esac
       done
}         




#Remote menu block
remote(){
        echo""
        rem1=0
        logd="rem1"
        while [ "$rem1" -ne 8 ];
        do
          printf "%*s\n" 40 "Welcome to Remote Options Menu"
          echo -e ""
          printf "%-45s %s \n" "Press 1 to SSH to client" "Press 2 to SCP a file to a client"
          printf "%-45s %s \n" "Press 3 to generate new SSH keys" "Press 4 to send key to remote host"
          printf "%-45s %s \n" "Press 5 to open cron" "Press 6 show known hosts"
          printf "%-45s %s \n" "Press 7 to WIP" "Press 8 to return to main menu"
          read -p $'Please choose an option:\n' rem1
          case $rem1 in 
          1)echo -e "This are the known hosts\n";echo -e "Number of known hosts:"${#known_hosts[@]}"\n"
            for i in "${!known_hosts[@]}"; do
              echo "$((i+1))) ${known_hosts[$i]}"
            done
            read -p $'Please insert a user name\n' usr
            read -p $'Please insert destination\n' dest
                ssh $usr@$dest;hostlogger;logman;;
          2)read -p $'Please insert file with full path:\n' fil
            read -p $'insert a user name\n' usr2
            read -p $'Please insert host ip:\n' host1
            read -p $'please insert target destination:\n' tar_dest
            scp $fil $usr2@$host1:$tar_dest;hostlogger;logman;;
          3)echo "...generating SSH key"
                ssh-keygen -t rsa -b 4096 -C;logman;;
          4)read -p $'Please insert destination:\n' dest3
            read -p $'Please insert username:\n' usr1    
                ssh-copy-id $usr1@$dest3;hostlogger;logman;;
          5)echo "Openenig cron tab"
                crontab -u "${SUDO_USER:-$USER}" -e;logman;;
          6)echo -e "Showing known hosts\n"
                cat $hostlog;logman;;
          7)echo "WIP"
                ;;
          8)echo "Returning to main menu"
                mainmenu=0;clear;return;;
          *)echo "Invalid option. Please try again.";;        
          esac
        done
}    
main_menu(){
         clear
         mainmenu=0
         choice=0
         filema=0
         bckp=0
         gcm=0
         mon1=0
         rem1=0
         while [ "$mainmenu" -ne 6 ];
         do 
           printf "%*s\n" 40 "================================"
           printf "%*s\n" 37 "Welcome to Easy Management"
           printf "%*s\n" 40 "================================"
           printf "%-45s %s \n"  "1)User Managment Menu" "2)Backup Menu"
           printf "%-45s %s \n"  "3)File manipulation Menu" "4)General Commands Menu"
           printf "%-45s %s \n"  "5)Monitoring Menu" "6)Remote Options Menu"
           printf "%-45s %s \n"  "7)Exit"
           read -p $'please choose an option:\n' mainmenu

           case $mainmenu in
               1) echo "User Managment Menu" 
                      menu;;
               2) echo "Backup Menu"
                      backup;;
               3) echo "File Manipulation Menu"
                      filemanip;;
               4) echo "General Commands Menu" 
                       generalcommandsmenu;; 
               5) echo "Monitoring Menu"
                       monitor;;
               6) echo "Remote Options Menu"
                       file_check;remote;;
               7) echo "exiting Easy Manager"
                      clear;exit 0;;
               *) echo "Invalid option. Please try again.";;

           esac
          done
}

#command logging block
logman(){
        if [ "$logd" == "choice" ]; then
        if [ "$choice" -eq 1 ]; then comd="adduser $name"; fi
        if [ "$choice" -eq 2 ]; then comd="deluser $name"; fi
        if [ "$choice" -eq 3 ]; then comd="lockuser $name"; fi
        if [ "$choice" -eq 4 ]; then comd="unlockuser $name"; fi
        if [ "$choice" -eq 5 ]; then comd="privileged_$name"; fi
    elif [ "$logd" == "bckp" ]; then
        if [ "$bckp" -eq 1 ]; then comd="set_backup_dir $dir1"; fi
        if [ "$bckp" -eq 2 ]; then comd="zip_dir $dir1"; fi
        if [ "$bckp" -eq 3 ]; then comd="archive_dir $dir1"; fi
        if [ "$bckp" -eq 4 ]; then comd="run_backup $dir1"; fi
    elif [ "$logd" == "filema" ]; then
        if [ "$filema" -eq 1 ]; then comd="create_file $fname"; fi
        if [ "$filema" -eq 2 ]; then comd="edit_file $fname"; fi
        if [ "$filema" -eq 3 ]; then comd="make_executable $fname"; fi
        if [ "$filema" -eq 4 ]; then comd="print_file $fname"; fi
    elif [ "$logd" == "gcm" ]; then
        if [ "$gcm" -eq 1 ]; then comd="apt update";fi
        if [ "$gcm" -eq 2 ]; then comd="apt upgrade";fi
        if [ "$gcm" -eq 3 ]; then comd="apt autoremove";fi
        if [ "$gcm" -eq 4 ]; then comd="apt purge $pack1";fi
        if [ "$gcm" -eq 5 ]; then comd="apt install $pack2";fi
     elif [ "$logd" == "mon1" ];then
        if [ "$mon1" -eq 1 ]; then comd="view processes";fi
        if [ "$mon1" -eq 2 ]; then comd="view cpu/mem usage";fi
        if [ "$mon1" -eq 3 ]; then comd="view the last 20 lines of syslog";fi
        if [ "$mon1" -eq 4 ]; then comd="view the last 20 lines of journalctl";fi
        if [ "$mon1" -eq 5 ]; then comd="view kernel log warnings";fi
     elif [ "$logd" == "rem1" ]; then
         if [ "$rem1" -eq 1 ]; then comd="ssh $usr@$dest";fi
         if [ "$rem1" -eq 2 ]; then comd="scp $fil $usr2@$host1:$tar_dest";fi
         if [ "$rem1" -eq 3 ]; then comd="generate new SSH key";fi
         if [ "$rem1" -eq 4 ]; then comd="ssh-copy-id $usr1@$dest3";fi
         if [ "$rem1" -eq 5 ]; then comd="edit $SUDO_USER crontab";fi
         if [ "$rem1" -eq 6 ]; then comd="Showing known hosts";fi    
     fi
         echo "$comd $SUDO_USER $(date)" >> /root/scr2.log
         
}

#remote function log
hostlogger(){
          ssh_log="1"
          scp_log="2"          
          if [ -n "$usr" ] && [ -n "$dest" ]; then ssh_log=1;
              if [ "$ssh_log" -eq 1 ];then entry="$usr@$dest"
                if ! grep -Fxq "$entry" "$hostlog";then 
                 echo $entry >> "$hostlog";fi
              fi
          elif [ -n "$usr2" ] && [ -n "$host1" ]; then scp_log=1;
              if [ "$scp_log" -eq 1 ];then entry="$usr2@$host1"
                if ! grep -Fxq "$entry" "$hostlog";then 
                 echo $entry >> "$hostlog";fi        
              fi   
          fi
}
#checks block
log_permission_check(){
                    log_perm="600"
                    hostlog_perm=$(stat -c "%a" "$hostlog")
                    if [ "$log_perm" != "$hostlog_perm" ];then
                      echo  "!!!log file permissions have been tampred check file!!!"
                      echo  "!!!changing permissions back to default!!!"
                      chmod 600 $hostlog
                    fi
}
file_check(){
          if ! [ -f $hostlog ];then 
            touch $hostlog
            chmod 600 "$hostlog"
            echo "Hostlog created"
          else
              log_permission_check
          fi
}
sudo_check(){
            if [ "$EUID" -ne 0 ]; then
              echo "This script must be run with sudo or root"
              exit 1
            fi
}
append_check(){
            grep -q $name /etc/passwd
}
group_check(){
            if ! grep -q script_group /etc/group; then
              echo "script_group not created creating script group"
              groupadd script_group
              touch /etc/sudoers.d/script_perm
              echo "%script_group ALL= NOPASSWD: /usr/local/bin/scr1" > /etc/sudoers.d/script_perm 

            fi
}

#running command
sudo_check
group_check
main_menu




