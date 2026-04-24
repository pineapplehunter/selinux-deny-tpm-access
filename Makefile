include /usr/share/selinux/devel/Makefile

install: my_trusted.pp
	sudo semodule -i $<

remove:
	sudo semodule -r my_trusted

@PHONY: install remove
