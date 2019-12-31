# AWS VPC and code for MCSA lab

-- VPC
### Windows Server 2008 R2 



### FSMO Roles



AD is the central repo in which all objects in an enterprise and their respetive attributes are stored. 

Hierarchical

Multi-master model or Single-master model (5 master op)

Single-Master Model
- only one DC in the entire directory is allowed to process updates
- Multiple different roles, roles can be transfered to any DC in the enterprise - **(roles are not bound to a single DC. they are referred to as a Single Master Operation *(FSMO)* roles)**
- There are 5 FSMO roles:
    1. Schema master
    2. Domain naming master
    3. RID master
    4. PDC emulator
    5. Infrastructure master


1. Schema Master FSMO Role
   - responsible for performing updates to the directory schema. This DC is the only one that can process updates to the directory schema. Once the update is complete it is replicated from the schema master to all other DCs in the directory. There is only one schema master per directory.
  
2. Domain Naming Master FSMO Role
   - Responsible for making changes to the forest-wide domain name space of the directory. Only one DC can have this role and this role will enable that DC to add or remove a domain from the directory. It can also add or remove cross references to domains in external directories.

