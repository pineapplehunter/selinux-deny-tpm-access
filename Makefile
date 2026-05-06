include /usr/share/selinux/devel/Makefile

install: my_trusted.pp
	sudo semodule -i $< -v
	sudo semanage fcontext -a -t my_tpm_device_t '/dev/tpm[0-9]*'
	sudo semanage fcontext -a -t my_tpm_device_t '/dev/tpmrm[0-9]*'
	sudo restorecon -rv /dev/tpm*

remove:
	sudo semodule -r my_trusted
	sudo restorecon -rv /dev/tpm*

@PHONY: install remove
