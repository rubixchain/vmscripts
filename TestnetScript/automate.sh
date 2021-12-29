#!/bin/bash

PS3="Enter your choice ==> "
echo "What do you want me to do?"

select answer in RemoveOldFiles StopJava StopIPFS StartIPFS CopyNewJarFile RunNewJar StartCurlRequest
do
        case $answer in
                RemoveOldFiles)
                        echo "give me the path of file with extension"
                        read path
                        echo "your selected file is $path"
                        # remove file command
                        for server in $(cat ~/ppshlists)
                        do
                           pssh -i -h ~/pssh-hosts rm /home/$server/$path 
                        done
                        ;;
                StopJava)
                        echo "Lets kill JAVA"
                        # Run command on remote
                        pssh -i -h ~/pssh-hosts  killall java
                        ;;
                StopIPFS)
                        echo "Lets kill IPFS"
                        # Run command on remote
                        pssh -i -h ~/pssh-hosts  killall ipfs
                ;;
                StartIPFS)
                        echo "Lets run IPFS Daemon"
                        # Run command on remote
                        pssh -i -h ~/pssh-hosts ipfs daemon
                ;;
                CopyNewJarFile)
                        echo "To Copy New Jar"
                        echo "give me the file location/path on this machine with extension Ex: Downloads/rubix01.jar"
                        read file
                        for server in $(cat ~/ppshlists)
                        do
                        # copy files
                        pscp -h ~/pssh-hosts ~/$file /home/$server

                        done
                        ;;
                RunNewJar)
                        echo "Lets Run the new Jar"
                        echo "give me the jar name with extension Ex: rubix01.jar"
                        read jarname
                        for server in $(cat ~/ppshlists)
                        do
                           pssh -i -h ~/pssh-hosts java -jar $jarname
                        done
                        ;;
                StartCurlRequest)
                        echo "Start_curlrequest"
                        pssh -i -h ~/pssh-hosts curl --header "Content-Type: application/json" --request GET 'http://localhost:1898/start'
                ;;
                *)
                        echo "Well, you need to enter something from the list!"
                        ;;
        esac
done