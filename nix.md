 

Standard Output (STDOUT) is where a program can send information to. It can go to a file, printer, or the screen. By default the shell directs output from STDOUT from a command to the screen. 

Standard Input (STDIN) is where a program can get information from.

When you first log in, the shell directs the STDOUT of our commands to the device file that represents the screen.
- cat command copies a file to STDOUT, because the shell directs the STDOUT to the screen. 

You can redirect STDOUT/STDIN. 
- \> is the redirect out symbol
  - $cat > file.txt
- \< is the redirect input symbol

\>> appends data to the end of a file

/dev/null is a data sink. You can direct input you do not want to /dev/null

\| - A pipe is used to connect the STDOUT of one process to STDIN of another process.
- commandA args | commandB args
  - what it actually does:
    - commandA args > tmp
    - commandB args < tmp
    - rm tmp

tee ---> copies STDIN to both a file and to STDOUT (default the screen)
- takes a single stream of input and sends the output in two directions
- tee saves a copy of STDIN to vmstat.out, and vmstat.out also sends a copy to STDOUT. 

#### INODE (information node)
- Every file in the system has an inode (index node)
- contains all file information **except the file contents and name**
  - an INODE contains:
    - metadata associated with a file
    - modification time stamp
    - owner
    - type
    - length
    - location

A **name** and **INODE** pair are called a link.



#### Links

a link is a pointer to a file. 

2 kinds of links:
- Soft (symbolic) links:
- indirect pointer to a file
  - Link to another name in the file system
  - have different **inode** number from the source's. 
  - when the source file is deleted, the soft link file is of no use.
  - Can create links between directories.
  - Can work across file systems
- Hard Links
  - pointer to a file and points to the inode
  -  have the same inode number as source
  - deleting, renaming or moving the original file will not affect the hard link as it links to the underlying inode
  - cannot create links between directories
  - cannot work across file systems


Soft links:
- similar to a short cut in windows.
- also known as a symbolic link. a file pointing to another file.
- INODE # of soft link is different than the INODE of the original file
- if you delete the original file, the soft links become useless. 

Hard links:
- different name of the same file
- same file size 
- same INODE #
---

### File Types

 By default only 3 types of files:
 1) Regular files ('-')
 2) Directory files ('d')
 3) Special files (5 types)
    1) Block file ('b')
    2) Character device file('c')
    3) Named pipe file or just pipe file ('p')
    4) Symbolic link file ('l')
    5) Socket files('s')
   ```
   k@laptop:~/DEMO$ ls -l
   total 4
   drwxrwxr-x 2 k k 4096 Dec  9 09:16 mydir
   -rw-rw-r-- 1 k k    0 Dec  9 09:16 myfile1
   -rw-rw-r-- 1 k k    0 Dec  9 09:16 myfile2
   lrwxrwxrwx 1 k k    7 Dec  9 09:16 my_link -> myfile1
   ```
- block file types
  - hardware files.
  - present in /dev.
  - created by fdisk or by partitioning
```
k@laptop:~/DEMO$ ls -l /dev/  | grep ^b
brw-rw----  1 root disk        7,   0 Dec  8 13:31 loop0
brw-rw----  1 root disk        8,   0 Dec  8 13:31 sda
brw-rw----  1 root disk        8,   1 Dec  8 13:31 sda1
brw-rw----  1 root disk        8,   2 Dec  8 13:31 sda2
brw-rw----  1 root disk        8,   3 Dec  8 13:31 sda3
```

- character device file type
  - provides a serial stream of input or output

---

### RAID
- Redundant Array of Independent Disks
- Levels:
  - 0: Striping. No mirroring or parity
    - Capicity is the sum of all the disks
    - Striping distributes the contents of each file among all disks
    - If any disk fails, all files and the RAID volume will be lost
  - 1: Mirroring. Without parity or striping
    - Data is written identically to two drives
  - 4: Block-level striping with parity
    - Stores parity on seperate disk
  - 5: Block-level striping with parity
    - Requires 3+ drives
    - Data blocks are striped across the drives and parity data is distributed over all the disks instead of storing them on a dedicated disk (RAID4)
    - Requires all drives but 1 be present
    - Can handle only a single disk failure
  - 6: Block-level striping with double parity blocks.
    - Each disk has 2 parity blocks which are stored on different disks across the array. 
    - Fault tolerance increases up to 2 drive failures in the array.
  - 10: RAID 1+0
    - Combines both RAID 1 and RAID 0 by layering them in opposite order
    - Hybrid or Nested 
    - Fast performance of RAID0 and the redundancy of RAID0

---

A process can be in one of the following states:

Process states

* R -   Running or runnable (on run queue)
* D -   Uninterruptible sleep (waiting for some event)
* S -	Interruptible sleep (waiting for some event or signal)
* T -	Stopped, either by a job control signal or because it is being traced by a debugger.
* Z -	Zombie process, terminated but not yet reaped by its parent.

STDIN ---> Standard In. Communicate information into the process. The stuff you type into the terminal is being sent to a running STDIN channel'

STDOUT ---> Convey the output from a running process.

STDERR ---> Any errors are communicated through STDERR.

NGINX

server blocks are used to define configuration details and host multiple domains on one server

- server blocks = virtual hosts in httpd


mkdir -p /var/www/salonzed.com/html
wget http://salonzed.com/af4h19.tar.gz -O /var/www/salonzed.com/html/salonzed.tar.gz
cd /var/www/salonzed.com/html/ && tar -xf salonzed.tar.gz
rm -rf salonzed.tar.gz



hard drives - storage - iops - inodes

ports
---

### Linux Boot Process

1) The first step of the boot process is the BIOS (Basic IO System)
   - BIOS initializes hardware (detects HDDs, USB, CDs, NICS, etc).
   - Then BIOS will step trhough each boot device based on the boot device order until if finds one it can successfully boot from. It then loads the MBR (or GPT)
2) After BIOS loads the hardware and finds the first boot device, the **boot loader** takes over. Different devices have different boot loaders:
   1) GRUB boot from HDD
   2) syslinux, boot from USB
   3) isolinux, boot from CD
   4) pxelinux, boot from network
3) Once a **kernel** is selected in GRUB, GRUB will **load the Linux kernel** into RAM and execute it.
   - GRUB will also load initrd which is the inital RAM disk.
     - initrd contains config files, kernel modules, and programs that the kernel needs in order to find and mount the real root file system.
     - Final step is executing /sbin/init which takes over the rest of the boot process.
4) /sbin/init - parent process of every program running on a system
   - Always has a PID of 1
   - Responsible for starting the rest of the process that make up a Linux system.


---

### Logging In

When you first log in via console, the shell first executes commands in /etc/profile then looks for ~/.bash_profile, ~/.profile, and ~/.bash_login. A command in any of these files will override the defaults set in /etc/profile.

When you log out, bash executes the commands in ~/.bash_logout

If you're already logged into a machine and open a new terminal window, .bashrc is executed.

~/.bash_profile ---> place to put stuff that applies to our whole session. ie startup programs and environment variables

~/.bashrc ---> place to put stuff that applies only to bash itself. ie alias, shell options, prompt settings




---
### Programs

#### drive management
fdisk ---> create, delete, modifying partions
parted

#### file management
dh



head - list first 10 lines of a file
- head -n50 ---> list first 50 lines

tail - list last 10 lines of a file
- tail =n50 ---> list last 50 lines

sed - stream editor. perform basic text transformations on an input stream (file or input). 
- sed **-i** ---> enables edits to the stream. means **edit file in-place**
- s/ ---> substition. replace character or string. (sed -i 's/A/a/g' file.txt) - replaces A with a throughout entire file
- /g ---> global. performs action throughout entire stream instead of first occurance

    ```
    $ cat text
    i wandered lonely as a cloud
    that floats on high o'er vales and hills,
    when all at once I saw a crowd,
    a host, of golden daffodils;
    beside the lake, beneath the trees,
    fluttering and dancing in the breeze.
    ```

    change a to A
    ```
    $ sed -i 's/a/A/g' text
    $ cat text
    i wAndered lonely As A cloud
    thAt floAts on high o'er vAles And hills,
    when All At once I sAw A crowd,
    A host, of golden dAffodils;
    beside the lAke, beneAth the trees,
    fluttering And dAncing in the breeze.
    ```

    change A to a
    ```
    $ sed -i 's/A/a/g' text
    $ cat text
    i wandered lonely as a cloud
    that floats on high o'er vales and hills,
    when all at once I saw a crowd,
    a host, of golden daffodils;
    beside the lake, beneath the trees,
    fluttering and dancing in the breeze.
    ```
dig - domain information groper
  - Query DNS name servers
  - ```$dig google.com``` returns the A record
  - ```$dig -x 12.34.5.6```
      - reverse lookup
      - return the corresponding domain name for that IP address
nslookup - name server lookup
- Query DNS to obtain domain name or IP address mapping

pinp - tests the network connection between the local machine and a remote address

traceroute - expands on ping
- provides a report on the path that the packets take to get from the local machine to the remote machine.
- based on ICMP.
- To discover the routers on the path to a destination, it uses the **TTL field** in the header of the ICMP packets.
  -   When a TCP packet is sent, its TTL is set (the # of routers (hops) it can pass through before the packet is discarded).
  -   As the packet passes through a router, the TTL is decremented and when the TTL reaches 0, the packet is destroyed and an ICMP 'time exceeded' message is returned.
-   Traceroute works by setting the TTL for a packet to 1 and sending it towards the requested destination host and listens for the reply. 
-   When the initiating machine receives a 'time exceeded' response, it examines the packet to find where it came from - this is the machine 1 hop away.
-   The initiating machine then sends a new packet with a TTL of 2 and uses the response to determine the machine 2 hops away, and so on.