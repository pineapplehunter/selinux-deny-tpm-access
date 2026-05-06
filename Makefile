include /usr/share/selinux/devel/Makefile

install: my_trusted.pp
	sudo semodule -i $< -v
	-sudo chmod 666 /dev/tpmrm*
	-sudo chcon -t my_tpm_device_t /dev/tpm*

remove:
	sudo semodule -r my_trusted
	sudo restorecon -rv /dev/tpm*

chcon-exe:
	sudo chgrp -v tss tpm2_pcrread
	sudo chcon -t my_trusted_exec_t tpm2_pcrread

@PHONY: install remove
