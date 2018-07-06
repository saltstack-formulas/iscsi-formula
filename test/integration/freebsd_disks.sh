mkdir -p /tmp/myfile/
truncate -s 20m /tmp/myfile/disk0.img
truncate -s 20m /tmp/myfile/disk1.img
truncate -s 20m /tmp/myfile/disk2.img
truncate -s 20m /tmp/myfile/disk3.img
mdconfig /tmp/myfile/disk0.img 
mdconfig /tmp/myfile/disk1.img 
mdconfig /tmp/myfile/disk2.img 
mdconfig /tmp/myfile/disk3.img 
