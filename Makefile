include /usr/share/selinux/devel/Makefile

# Install policy module and apply immediate labels to TPM devices
install: my_trusted.pp
	sudo semodule -i $< -v
	-sudo chmod 666 /dev/tpmrm*
	-sudo chcon -t my_tpm_device_t /dev/tpm*

# Remove policy module and restore default labels
remove:
	sudo semodule -r my_trusted
	sudo restorecon -rv /dev/tpm*

# Label tpm2_pcrread executable to run in my_trusted_t domain
chcon-exe:
	sudo chcon -t my_trusted_exec_t tpm2_pcrread

@PHONY: install remove chcon-exe
