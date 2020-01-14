all: build-module install reload

clean:
	rm -rf premake/projects
	rm -rf bin

install:
	sudo apxs -i -a -n angelscript bin/mod_angelscript.so

reload:
	sudo service apache2 restart

build-module:
	cd premake; premake5 gmake
	cd premake/projects/gmake; make

