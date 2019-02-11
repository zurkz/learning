 

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

#### INODE
- Every file in the system has an inode (index node)
- contains all file information **except the file contents and name**
  - an INODE contains:
    - Inode number
    - File size
    - Owner info
    - Permissions
    - File Type
    - Number of links

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
### Programs

#### drive management
fdisk ---> create, delete, modifying partions
parted

#### file management
dh