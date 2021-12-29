# Shell script of rubix physical testnets

## How to use
  1. from testnet01 machine go to the Documentes/scripts folder & open a terminal 
  2. run the command "bash automate.sh"
  3. choose the option according to the operation you want to perform.
  4. hit enter 
  5. sit back your job done.
  


## How it was made
    1. Randomly Choose any one system as a gateway to all other systems in the network
    2. Let say the choosen system as main system
    3. Install ssh on all systems (you will get 2 files - id_rsa,id_rsa.pub) 
    4. From the main system add all other systems id_rsa.pub key using the below command to avoid entering passwords everytime.
        ssh-copy-id -i /home/testnet01/.ssh/id_rsa.pub "ip address"
        EX: ssh-copy-id -i /home/testnet01/.ssh/id_rsa.pub testnet23@192.168.1.218
        Note: make sure  you know the username and passwords of all the systems & it is required only once 
    5. By now the main sytem is ready to authenticate with each system
    6. Now install pssh on main system
    7. Using the pssh we can execute and run commands on all system from main system terminal. 


## Reference Links
https://www.golinuxcloud.com/pssh-commands-parallel-ssh-linux-examples/
https://www.golinuxcloud.com/generate-ssh-key-linux/
https://www.cyberciti.biz/cloud-computing/how-to-use-pssh-parallel-ssh-program-on-linux-unix/
https://www.tecmint.com/execute-commands-on-multiple-linux-servers-using-pssh/