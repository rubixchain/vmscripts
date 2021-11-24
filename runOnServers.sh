# Use this script to update the existing VMs 
# Download gamma.jar from dropbox and 
# Alter the script to use gamma.jar instead of beta.jar

# use [set -e] option before all the commands to stop execution of the commands
# set -e

port=5522

createUser() {
    local server="$1"
    local user="$2"
    local password="$3"
    local rootUser="$4"
    local rootPwd="$5"

    echo $password
    echo $user
    commandOutput="`sshpass -p $rootPwd ssh $rootUser@$server -p $port -T -o StrictHostKeyChecking=no -q 2>&1 <<SSH_CMDS
    echo "$rootPwd" | sudo -S useradd $user -m -g sudo < /dev/null
    echo "$user:$password"|chpasswd
    usermod -s /bin/bash "$user" 
SSH_CMDS`"
    
}

addBootStrap() {
    local server="$1"
    local user="$2"
    local password="$3"
    
    commandOutput="`sshpass -p $password ssh $user@$server -p $port -T -o StrictHostKeyChecking=no 2>&1 <<SSH_CMDS
    #ipfs bootstrap add "/ip4/115.124.117.112/tcp/4001/p2p/QmNVWB6fmNrBS1vRnx8VGKzq8rQHxG1R7KA2HCxFEWu2GL"
    #ipfs bootstrap add  "/ip4/115.124.117.129/tcp/4001/p2p/QmXRWzWfZnSuma5pTuGHtCRUWzmAWTaN1xHXhm5eQqCRwC"
    #ipfs bootstrap add  "/ip4/115.124.117.37/tcp/4001/p2p/QmWXELAoKJsCMFoW3j6pFmXEhouwKgWiK7wN6uLyuX6ULV"
    #ipfs bootstrap add  "/ip4/115.124.117.38/tcp/4001/p2p/QmTSoQqf8i18k7EpLRfWCm4i8Gu4uTjvW7bB7Le4w8yoSh"
    #ipfs bootstrap add  "/ip4/115.124.117.39/tcp/4001/p2p/QmbpCaCFXtXeL5NnLpJ4kuRSNJXRwa1JexM8cRTQ4QQA88"
    #ipfs bootstrap add  "/ip4/115.124.117.40/tcp/4001/p2p/QmSFqWzAdjAWCL1LX9SBUcpdvFCPzGHXsu67LXVsbB6cm7"
     ipfs config --json Swarm.ConnMgr.HighWater 2000
     ipfs config --json Swarm.ConnMgr.LowWater 500
    bash ~/runfiles/killAllScreens.sh
    bash ~/runfiles/initIpfsDelta.sh
    sleep 5
    bash ~/runfiles/startRubix.sh
SSH_CMDS`"
    
}
putFiles() {

# Script to put executable scripts into the nodes
    local server="$1"
    local user="$2"
    local password="$3"

    #echo Putting executable scripts into the nodes

    output="`sshpass -p $password sftp -P $port -o StrictHostKeyChecking=no $user@$server <<CMD

    #put -P /home/$USER/vmscripts/59jar/initIpfsDelta.sh runfiles/
    #put -P /home/$USER/vmscripts/59jar/delta-ping-59.jar runfiles/


    #put -P /home/$USER/vmscripts/stopRubix.sh runfiles/
    #put -P /home/$USER/runfiles/killScreens.sh runfiles/
    #put -P /home/$USER/vmscripts/runfiles/initIpfsDelta.sh runfiles/
    #put -P /home/$USER/runfiles/startRubix.sh runfiles/
    #put -P /home/$USER/Rubix/config.json Rubix/

    #rmdir runfiles
    #mkdir runfiles
    #put -P /home/$USER/vmscripts/runfiles/freshInstall.sh runfiles/
    #put -P /home/$USER/vmscripts/runfiles/createDID.sh runfiles/
    #put -P /home/$USER/vmscripts/runfiles/startRubix.sh runfiles/
    #put -P /home/$USER/vmscripts/runfiles/resetInvalidTokens.sh runfiles/
    #put -P /home/$USER/vmscripts/runfiles/FindExtraTokens.jar runfiles/
    #put -P /home/$USER/vmscripts/runfiles/FindExtraTokens.jar runfiles/
    #put -P /home/$USER/vmscripts/changeHostName.sh runfiles/
    #put -P /home/$USER/vmscripts/runfiles/delta-ping-16.jar runfiles/
    #put -P /home/$USER/vmscripts/jsonHelper.sh runfiles/
    #put -P /home/$USER/vmscripts/runfiles/connectSwarm.sh runfiles/
    #put -P /home/$USER/vmscripts/runfiles/ipfsReinit.sh runfiles/

    #put -P runfiles/stopTxns.sh runfiles/

    #mkdir tfrToken
    #mkdir tfrToken/logs
    #put -P /home/$USER/vmscripts/tfrToken/tfrCore.sh tfrToken/
    #put -P /home/$USER/vmscripts/tfrToken/config.sh tfrToken/
    #put -P /home/$USER/vmscripts/tfrToken/runTransfer.sh tfrToken/
    #put -P /home/$USER/vmscripts/tfrToken/cancelAndRestart.sh tfrToken/
    #get deltaOutput.log logs/$server.log

    #mkdir nodeMonitor
    #put -P /home/$USER/vmscripts/nodeMonitor/config.sh nodeMonitor/
    #put -P /home/$USER/vmscripts/nodeMonitor/main.sh nodeMonitor/
    #put -P /home/$USER/vmscripts/nodeMonitor/backupNodes.sh nodeMonitor/

    #mkdir mineToken
    #mkdir mineToken/logs
    #put -P /home/$USER/vmscripts/runfiles/mineCore.sh mineToken/
    #put -P /home/$USER/vmscripts/runfiles/runTransfer.sh mineToken/    

    #rm nodeMonitor/rsyncBackup
    #mkdir nodeMonitor/rsyncBackup
    #put -P /home/$USER/nodeMonitor/rsyncBackup/rsyncBackup.sh nodeMonitor/rsyncBackup
    #put -P /home/$USER/nodeMonitor/rsyncBackup/killRunningRsyncBackupProcesses.sh nodeMonitor/rsyncBackup/
    #put -P /home/$USER/nodeMonitor/rsyncBackup/startRsyncBackup.sh nodeMonitor/rsyncBackup/

    #put -P /home/$USER/vmscripts/runfiles/log4jWallet.properties Rubix/LOGGER/

    #put -P /home/$USER/pyscripts/backTH.pyc runfiles/
    put -P /home/$USER/pyscripts/moveLogs.pyc runfiles/
    #put -P /home/$USER/pyscripts/tokenCheck.pyc runfiles/
    #put -P /home/$USER/pyscripts/tfrDaemon.pyc tfrToken/
    #put -P /home/$USER/pyscripts/doTransfer.sh
CMD`"

    #output="`sshpass -p $password ssh $user@$server -p $port -T -o StrictHostKeyChecking=no -q 2>&1 <<CMD
#chmod +x ~/doTransfer.sh
#CMD`"
}

getInstalledStatus() {
    local server="$1"
    local user="$2"
    local password="$3"
    
    #echo Putting executable scripts into the nodes
    output="`sshpass -p $password sftp $user@$server <<CMD
    get -P /home/$USER/.rubixInstalled "installed_on_${server}"
    rm /home/$USER/runfiles/createDID.sh
CMD`" 
    
}
installDependencies() {

# Script to execute a fresh install
    local server="$1"
    local user="$2"
    local password="$3"

    echo "executing for the server $server"
    commandOutput="`sshpass -p $password ssh $user@$server -p $port -T -o StrictHostKeyChecking=no 2>&1 <<SSH_CMDS
    nohup /home/$user/runfiles/freshInstall.sh '$password' > install.out 2> install.err < /dev/null &
SSH_CMDS`"
echo $commandOutput
}

createDID() {
#script for creating DID
    local server="$1"
    local user="$2"
    local password="$3"

echo "executing for the server $server"
    commandOutput="`sshpass -p $password ssh $user@$server -p $port -T -o StrictHostKeyChecking=no 2>&1 <<SSH_CMDS
    runfiles/initIpfsDelta.sh  
    nohup runfiles/createDID.sh > didCreate.out didCreate.err < /dev/null &
SSH_CMDS`"

}

storeDID() {
#script for storing DID
    local server="$1" 
    local user="$2"
    local password="$3"
    local didFile="didKeys.txt"
    local didRaw="didRaw.txt"
    local hostnameCmd="cat /etc/hostname"
    local hostname
    local ipfsId

    local didHashCommand="cat ~/Rubix/DATA/DID.json"
    local didIpfsCommand="ipfs id"

	#local didJson="`sshpass -p $password ssh $user@$server -p $port -To StrictHostKeyChecking=no -q  "$didHashCommand"  2>&1`"
    local didJson="`sshpass -p $password ssh $user@$server -p $port -To StrictHostKeyChecking=no "$didHashCommand" < /dev/null`"
    local hostname="`sshpass -p $password ssh $user@$server -p $port -To StrictHostKeyChecking=no "$hostnameCmd" < /dev/null`"
    local ipfsId="`sshpass -p $password ssh $user@$server -p $port -To StrictHostKeyChecking=no "$didIpfsCommand" < /dev/null`"

	# Get DD Hash from JSON
	local didHash=`echo $didJson | jq -r '.[0].didHash'`
    local walletHash=`echo $didJson | jq -r '.[0].walletHash'`
	local peerid=`echo $didJson | jq -r '.[0].peerid'`
    local peerid2=`echo $ipfsId | jq -r '.ID'`
	echo "Storing DID Hash..."

	# Store DID Hash
	`echo "$server : $hostname : $didHash : $peerid2 : $peerid : $walletHash"  >> $didFile`
}

reinitServer() {
#Script for reinitializing servers
    local server="$1"
    local user="$2"
    local password="$3"
echo "executing for the server $server"
    commandOutput="`sshpass -p $password ssh $user@$server -p $port -T -o StrictHostKeyChecking=no 2>&1 <<SSH_CMDS
    nohup ./runfiles/initIpfsDelta.sh
SSH_CMDS`"

}

startRubix() {
#Script for reinitializing servers
    local server="$1"
    local user="$2"
    local password="$3"
echo "executing for the server $server"
    commandOutput="`sshpass -p $password ssh $user@$server -p $port -T -o StrictHostKeyChecking=no 2>&1 <<SSH_CMDS
    nohup ./runfiles/startRubix.sh &
SSH_CMDS`"

}

getAcInfo() {
#script for storing Balance
    local server="$1"
    local user="$2"
    local password="$3"
    local acFile="AcInfo.txt"
    local acInfoCmd="cat accinfo.txt"
    local hostnameCmd="cat /etc/hostname"
    local acBalCmd="ls -1 /home/$user/Rubix/Wallet/TOKENS | wc -l"
    local hostname
    
    local didHashCommand="curl --request GET http://localhost:1898/getAccountInfo"

    hostname="`sshpass -p $password ssh $user@$server -p $port -To StrictHostKeyChecking=no "$hostnameCmd" < /dev/null`"
    acBal="`sshpass -p $password ssh $user@$server -p $port -To StrictHostKeyChecking=no "$acBalCmd" < /dev/null`"

    # Store Balance and DID
    echo "Storing Account Infomation"
	echo "$server:$hostname:$acBal" >> $acFile

    
}

getSPCount() {
#script for Getting Swarm Peer Counts
    local server="$1"
    local user="$2"
    local password="$3"
    local spCntFile="spCount.txt"
    local acInfoCmd="cat accinfo.txt"
    local hostnameCmd="cat /etc/hostname"
    local spCntCmd="ipfs swarm peers | wc -l"
    local spCount
    local hostname
    

    #hostname="`sshpass -p $password ssh $user@$server -p $port -To StrictHostKeyChecking=no "$hostnameCmd" < /dev/null`"
    spCount="`sshpass -p $password ssh $user@$server -p $port -To StrictHostKeyChecking=no "$spCntCmd" < /dev/null`"
    acBal=$((acBal-2))
	
    # Store Balance and DID
    echo "Getting Swarm Peer Count for $server"
	echo "$server:$spCount" >> $spCntFile

    
}

getRewardBalance() {
    #script for storing Points Earned
    local server="$1"
    local user="$2"
    local password="$3"
    local crFile="allPoints.txt"
    local pointsCmd="cat points.txt"

    local pointsCommand="curl --request GET 'http://localhost:1898/getTransactionHeader'"

        local pointsJson="`sshpass -p $password ssh $user@$server -p $port -To StrictHostKeyChecking=no  2>&1 <<SSH_CMDS
	curl --header "Content-Type: application/json" --request GET 'http://localhost:1898/getTransactionHeader' > points.txt
SSH_CMDS`"

   	local didJson="`sshpass -p $password ssh $user@$server -p $port -To StrictHostKeyChecking=no "$pointsCmd" < /dev/null`"
	
    # Get Details from JSON
    local spentCr="`echo $didJson | jq '.data.spentCredits'`"
	local unspentCr="`echo $didJson | jq '.data.unspentCredits'`"
	local totTxns="`echo $didJson | jq '.data.txnCount'`"
	local maxCr="`echo $didJson | jq '.data.maxCredits'`"
    

    # Store Balance and DID
    echo "Storing Credit Infomation"
	echo "$server : $unspentCr: $spentCr " >> $crFile
    
}

stopRubix() {
    #Script for stopping servers
    local server="$1"
    local user="$2"
    local password="$3"
echo "executing for the server $server"
    commandOutput="`sshpass -p $password ssh $user@$server -p $port -T -o StrictHostKeyChecking=no 2>&1 <<SSH_CMDS
    nohup ./runfiles/stopRubix.sh &
SSH_CMDS`"

}

zipRubix() {
    #Script for stopping servers
    local server="$1"
    local user="$2"
    local password="$3"
echo "executing for the server $server"
    commandOutput="`sshpass -p $password ssh $user@$server -p $port -T -o StrictHostKeyChecking=no 2>&1 <<SSH_CMDS
    nohup zip -r rubix{$1}.zip Rubix &
SSH_CMDS`"

}

initNode() {
    #Script for stopping servers
    local server="$1"
    local user="$2"
    local password="$3"
    local host="$4"
    
    commandOutput="`sshpass -p $password ssh $user@$server -p $port -o StrictHostKeyChecking=no 2>&1 <<SSH_CMDS
    touch ~/.hushlogin
    echo $password |sudo -S hostnamectl set-hostname $host
SSH_CMDS`"
#echo $commandOutput
}

getZip() {
    #Script for stopping servers
    local server="$1"
    local user="$2"
    local password="$3"
    
    output="`sshpass -p $password sftp $user@$server <<CMD
    get rubix{$1}.zip

CMD`" 

}

repairDelta() {
    #Script for reinitializing servers
    local server="$1"
    local user="$2"
    local password="$3"
echo "executing for the server $server"
    commandOutput="`sshpass -p $password ssh $user@$server -p $port -T -o StrictHostKeyChecking=no 2>&1 <<SSH_CMDS
    cd runfiles
    screen -ls | grep '(Detached)' | awk '{print $1}' | xargs -I % -t screen -X -S % quit
    killall -9 screen
    screen -wipe
    screen -wipe
    screen -dm bash -c 'ipfs daemon; exec sh'
    java -jar SetupStructure.jar
    screen -dmL -Logfile ~/deltaOutput.log bash -c 'java -jar delta.jar; exec sh'
SSH_CMDS`"

    
}

rebootServers() {
    #Script for reinitializing servers
    local server="$1"
    local user="$2"
    local password="$3"

  commandOutput="`sshpass -p $password ssh $user@$server -p $port -T -o StrictHostKeyChecking=no 2>&1 <<SSH_CMDS
  echo $password |sudo -S reboot
SSH_CMDS`"

}

killScreens() {
    #Script for reinitializing servers
    local server="$1"
    local user="$2"
    local password="$3"

  commandOutput="`sshpass -p $password ssh $user@$server -p $port -T -o StrictHostKeyChecking=no 2>&1 <<SSH_CMDS
  bash ./runfiles/killScreens.sh
SSH_CMDS`"

}

installOthers() {
    #Script for installing other dependancies; change install command to whatever required below
    local server="$1"
    local user="$2"
    local password="$3"

  commandOutput="`sshpass -p $password ssh $user@$server -p $port -t -o StrictHostKeyChecking=no <<SSH_CMDS
	echo $password |sudo rm -rf ~/runfiles/createDID.sh
	echo $password |sudo rm -rf /var/lib/apt/lists/*
SSH_CMDS`"

  commandOutput="`sshpass -p $password ssh $user@$server -p $port -T -o StrictHostKeyChecking=no <<SSH_CMDS
  #timedatectl set-timezone Asia/Kolkata
  echo $password |sudo -S apt-get update
  echo $password |sudo -S apt install jq -y
  echo $password |sudo -S apt install sshpass -y
  crontab -r
  crontab <<CRON 
*/30 * * * * /bin/bash ~/nodeMonitor/main.sh >> ~/nodeMonitor/cron.log 2>&1
30 03 * * * /bin/bash ~/nodeMonitor/backupNodes.sh >> ~/nodeMonitor/cron.log 2>&1
CRON
SSH_CMDS`"
}

installCron() {
    #Script for installing other dependancies; change install command to whatever required below
    local server="$1"
    local user="$2"
    local password="$3"

  commandOutput="`sshpass -p $password ssh $user@$server -p $port -T -o StrictHostKeyChecking=no <<SSH_CMDS
  crontab -r
  crontab <<CRON
#*/30 * * * * /bin/bash ~/nodeMonitor/main.sh >> ~/nodeMonitor/cron.log 2>&1
30 06 * * * python3 ~/runfiles/moveLogs.pyc >> ~/runfiles/movebck.log 2>&1
CRON
SSH_CMDS`"
}

prepareNodeData() {
    local server="$1" 
    local user="$2"
    local password="$3"
    local host="$4"

    local didFile="nodes.txt"
    local didHashCommand="cat ~/Rubix/DATA/DID.json"

    local didJson="`sshpass -p $password ssh $user@$server -p $port -To StrictHostKeyChecking=no "$didHashCommand" < /dev/null`"

    # Get DD Hash from JSON
    local didHash=`echo $didJson | jq '.[0].didHash'`
    local peerid=`echo $didJson | jq '.[0].peerid'`

    local host="`sshpass -p $password ssh $user@$server -p $port -To StrictHostKeyChecking=no <<SSH_CMDS
	hostname
SSH_CMDS`"

    # Store DID Hash
    `echo "$server : $port : $didHash : $peerid : $user : $password : $host" >> $didFile`
}

getFileLists() {
    local server="$1"
    local user="$2"
    local password="$3"
    local listFile="fileList.txt"
    local listFileCmd="ls -1a runfiles/"
    local hostnameCmd="cat /etc/hostname"
    local hostname
    
    hostname="`sshpass -p $password ssh $user@$server -p $port -To StrictHostKeyChecking=no "$hostnameCmd" < /dev/null`"
    fileList="`sshpass -p $password ssh $user@$server -p $port -To StrictHostKeyChecking=no "$listFileCmd" < /dev/null`"
	
    # Store Balance and DID
    echo "Storing Account Infomation"
	echo "$server:$hostname:$fileList" >> $listFile
    
}

stopTxns() {
    #Script for stopping the transactions - just kill the screen first 
    local server="$1"
    local user="$2"
    local password="$3"
    local stopTxnsCmd="~/runfiles/stopTxns.sh"

    hostname="`sshpass -p $password ssh $user@$server -p $port -To StrictHostKeyChecking=no "$stopTxnsCmd" < /dev/null`"

}

startIncrementalBackupService() {
    #Start Incremental Backup Service
    local server="$1"
    local user="$2"
    local password="$3"
    local commandOutput

    commandOutput="`sshpass -p $password ssh $user@$server -p $port -T -o StrictHostKeyChecking=no -q 2>&1 <<SSH_CMDS
	if ! [ "$(command -v inotifywait)" ]
	then
		echo "inotifywait not found. Installing..."
		echo $password | sudo -S apt install -y inotify-tools
	else
		echo "inotifywait already installed."
	fi

        cd nodeMonitor/rsyncBackup

        bash killRunningRsyncBackupProcesses.sh

        #bash startRsyncBackup.sh

    echo "Done"
SSH_CMDS`"

   printf "$commandOutput" >> rsyncBackupInstall.out
   echo $'\n' >> rsyncBackupInstall.out
}

getJARFileName() {
    local server="$1"
    local user="$2"
    local password="$3"
    local getJARFileNameCmds=`cat "/home/$USER/vmscripts/getJARName.sh"`
    local getJARFileNameOutFile="/home/$USER/vmscripts/outGetJARFileName.out"
    local commandOutput

    commandOutput="`sshpass -p $password ssh $user@$server -p $port -T -o StrictHostKeyChecking=no -q 2>&1 <<SSH_CMDS
    $getJARFileNameCmds
SSH_CMDS`"

   printf "$server : " >> $getJARFileNameOutFile
   printf "$commandOutput" >> $getJARFileNameOutFile
   echo $'\n' >> $getJARFileNameOutFile
}

init() {
    # Check if Servers List File Exists
    serversListFile=$2
    echo $2
    
    if [ -r $serversListFile ]
    then
        server="localhost"
        user=""
        password=""
        createUser=""
        rootUser=""
        rootUserPwd=""
        count=0
        instType=$1
        host=""

        # Read Servers list file Line by Line

        while IFS="" read -r line || [ -n "$line" ]
        do
            # Install the dependencies on the server
            count=$((count+1))
            firstChar=$(printf '%.1s' "$line")
            echo $line
            # Skip Comments
            if [ "$firstChar" != "#" ]
            then
                # Put the Variable name and Value into the respective Variables
                tmpServer=$(echo $line | awk -F ' ' '{print $1}')
                tmpUser=$(echo $line | awk -F ' ' '{print $2}')
                tmpPassword=$(echo $line | awk -F ' ' '{print $3}')
                rootUser=$(echo $line | awk -F ' ' '{print $4}')
                rootPwd=$(echo $line | awk -F ' ' '{print $5}')
                host=$(echo $line | awk -F ' ' '{print $6}')
                # Remove leading and trailing spaces
                #tmpServer="`echo $tmpServer`"
                #tmpCreateUser="`echo $tmpCreateUser`"

                echo "Processing for Server # $count"
                case "$instType" in 
                    # Creating a new user 
                    "0") 
                    echo "Creating new user on the server"
                    createUser $tmpServer $tmpUser $tmpPassword $rootUser $rootPwd
                    ;;
                    
                    # putting the executables into the server
                    "1") 
                    echo "Putting Executables into the server"
                    putFiles $tmpServer $tmpUser $tmpPassword 
                    
                    ;;

                    # Installing the dependencies
                    "2") 
                    echo "Installing dependencies in the server"
                    installDependencies $tmpServer $tmpUser $tmpPassword ;;

                    # Creating DID
                    "3") 
                    echo "Creating DID on server"
                    # Kalpana - Commented to prevent accidental running of CreateDid in existing Wallets
                    #createDID $tmpServer $tmpUser $tmpPassword 
                    ;;

                    # storing DID Hash
                    "4") 
                    echo "Storing DID information"
                    storeDID $tmpServer $tmpUser $tmpPassword ;;

                    # Reinitializing the servers
                    "5") 
                    echo "Reinitializing the server - Init IPFS and Delta"
                    reinitServer $tmpServer $tmpUser $tmpPassword ;;

                    # Running the start command
                    "6") 
                    echo "Starting Rubix service"
                    startRubix $tmpServer $tmpUser $tmpPassword ;;

                    # Getting Account Information
                    "7") 
                    echo "Getting account information"
                    getAcInfo $tmpServer $tmpUser $tmpPassword ;;

                    # Getting Points Information
                    "8") 
                    echo "Get points balance"
                    getRewardBalance $tmpServer $tmpUser $tmpPassword ;;

                    # stop Rubix Server
                    "9")
                    echo "Stop Rubix Server"
                    stopRubix $tmpServer $tmpUser $tmpPassword ;;
                    
                    # Create zip of the Rubix Folder
                    "10")
                    echo "Zipping Rubix Folder"
                    zipRubix $tmpServer $tmpUser $tmpPassword ;;
                    
                    # Create zip of the Rubix Folder
                    "11")
                    echo "Getting the zip file"
                    getZip $tmpServer $tmpUser $tmpPassword ;;
                    
                    
                    # Create zip of the Rubix Folder
                    "12")
                    echo "Repairing Wallet"
                    repairDelta $tmpServer $tmpUser $tmpPassword ;;
                    
                    "13")
                    echo "rebooting the server"
                    rebootServers $tmpServer $tmpUser $tmpPassword;;
                    
                    "14")
                    echo "Silencing the login message and providing HostName"
                    initNode $tmpServer $tmpUser $tmpPassword $host;;
                    
                    "15")
                    echo "Installing jq "
                    installOthers $tmpServer $tmpUser $tmpPassword $host;;
                    
                    "16")
                    echo "Getting installed Status"
                    getInstalledStatus $tmpServer $tmpUser $tmpPassword ;;
		    
                    "17")
                    echo "install Cron"
                    installCron $tmpServer $tmpUser $tmpPassword ;;
    
                    "18")
                    echo "prepare node data"
                    prepareNodeData $tmpServer $tmpUser $tmpPassword $host;;
            
                    "19")
                    echo "Killing all active screens"
                    killScreens $tmpServer $tmpUser $tmpPassword $host;;

                    "21")
                    echo "adding bootstrap nodes"
                    addBootStrap  $tmpServer $tmpUser $tmpPassword $host;;
                    
                    "22")
                    echo "Getting file lists"
                    getFileLists  $tmpServer $tmpUser $tmpPassword $host;;
                    
                    "23")
                    echo "Getting Swarm Peer Count"
                    getSPCount  $tmpServer $tmpUser $tmpPassword $host;;
                    
                    "24")
                    echo "Stopping Transactions"
                    stopTxns  $tmpServer $tmpUser $tmpPassword $host;;
                    
                    "25")
                    echo "Starting Incremental Backup"
                    startIncrementalBackupService $tmpServer $tmpUser $tmpPassword $host;;
                    
                    "26")
                    echo "Getting JAR file Name..."
                    getJARFileName $tmpServer $tmpUser $tmpPassword $host;;
               esac
            fi
            
        done < $serversListFile

    else
            bell
            echo "$serversListFile file not found or not Accessible"
            exit 1
    fi
    
}
init $1 $2
