all: build-module install reload

clean:
	rm -rf premake/projects
	rm -rf bin

install:
	sudo apxs -i -a -n atest2 bin/mod_atest2.so

reload:
	sudo service apache2 restart

build-module:
	cd premake; premake5 gmake
	cd premake/projects/gmake; make

