instructions to set up shared drive:

1. create a folder on your main file system where you want your project files to go. mine is /seng440/project
2. shut down the vm
3. (im using UTM, might be different on yours), go to the VM settings, then go to sharing
4. add the path of your folder and set VirtFS as the directory share mode
5. save settings
6. start the vm
7. once in, run 'sudo modinfo 9pnet_virtio'  <- this existed already for my when i did it. 
8. go to the lowest/root level, and run 'sudo mkdir -p /mnt/host'
9. after that run 'sudo mount -t 9p -o trans=virtio,version=9p2000.L,rw share /mnt/host'  <- mnt/host is where the shared files will appear
10. run 'share    /mnt/host   9p    trans=virtio,version=9p2000.L,rw,_netdev,nofail,auto   0 0'
11. now, if you go add a folder in your project folder on your pc, itll appear in /mnt/host


Once that works, run these steps to add the mounting process as part of the startup routing
1. run 'sudo vi /etc/fstab'
2. add 'share   /mnt/host   9p   trans=virtio,version=9p2000.L,rw,_netdev,nofail,auto   0 0'   into the file. esc :wq enter to save and exit


3. to test that it worked, run 'sudo umount /mnt/host' and then run 'sudo mount -a'. after, run 'ls /mnt/host', you should see the shared files. 