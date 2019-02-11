## ANSIBLE
https://www.bogotobogo.com/DevOps/Ansible/Ansible_SettingUp_Webservers_Nginx_Install_Env_Configure_Deploy_App.php

A configuration management and provisioning tool

Two types of servers:
1) Controlling Machines ---> there is a single controlling machine which is where orchestration starts. Controlling machine describes the location of nodes through its inventory.
2) Nodes ---> managed by a controlling machine over SSH and run the configured Tasks.

Ansible tasks are **idempotent** meaning that no matter how many times you run the task, the results will be the same.

* Facts ---> system and environment info gathered by Ansible. The context. Collected before running Tasks.
* Tasks ---> check the state of a system and see if it needs to change anything to get the system to the desired state.

Ansible is agentless. It works by connecting to the nodes and pushing out small programs, called Ansible Modules. The modules are written to be resource models of the desired state of the system. Ansible then executes these modules (over ssh) and removes them when finished. 

The modules can be located on any machine. No servers, daemons, or databases are required. 