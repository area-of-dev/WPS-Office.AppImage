# Copyright 2020 Alex Woroschilow (alex.woroschilow@gmail.com)
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
PWD:=$(shell pwd)

.PHONY: all

all: clean init
	mkdir --parents $(PWD)/build/Boilerplate.AppDir/wpsoffice
	$(PWD)/bin/apprepo.AppImage --destination=$(PWD)/build appdir boilerplate \
		libicu66 libicu-dev \
	    libselinux1  libwayland-cursor0

	echo 'PYTHONPATH=$${PYTHONPATH}:$${APPDIR}/wpsoffice' 							>> $(PWD)/build/Boilerplate.AppDir/AppRun
	echo 'export PYTHONPATH=$${PYTHONPATH}' 										>> $(PWD)/build/Boilerplate.AppDir/AppRun
	echo '' 																		>> $(PWD)/build/Boilerplate.AppDir/AppRun
	echo '' 																		>> $(PWD)/build/Boilerplate.AppDir/AppRun
	echo 'case "$${1}" in' 															>> $(PWD)/build/Boilerplate.AppDir/AppRun
	echo "  '--writer') exec \$${APPDIR}/wpsoffice/wps \$${*:2} ;;" 				>> $(PWD)/build/Boilerplate.AppDir/AppRun
	echo "  '--spreadsheets') exec \$${APPDIR}/wpsoffice/et \$${*:2} ;;" 			>> $(PWD)/build/Boilerplate.AppDir/AppRun
	echo "  '--presentation') exec \$${APPDIR}/wpsoffice/wpp \$${*:2} ;;" 			>> $(PWD)/build/Boilerplate.AppDir/AppRun
	echo "  '--pdf') exec \$${APPDIR}/wpsoffice/wpspdf \$${*:2} ;;" 				>> $(PWD)/build/Boilerplate.AppDir/AppRun
	echo '  *)   $${APPDIR}/wpsoffice/wps $${@} ;;' 	                            >> $(PWD)/build/Boilerplate.AppDir/AppRun
	echo 'esac' 																	>> $(PWD)/build/Boilerplate.AppDir/AppRun

	wget --output-document=$(PWD)/build/build.deb https://wdl1.pcfg.cache.wpscdn.com/wpsdl/wpsoffice/download/linux/11719/wps-office_11.1.0.11719.XA_amd64.deb
	dpkg -x $(PWD)/build/build.deb $(PWD)/build

	cp --recursive --force $(PWD)/build/opt/kingsoft/wps-office/office*/* \
		$(PWD)/build/Boilerplate.AppDir/wpsoffice

	rm --force $(PWD)/build/Boilerplate.AppDir/*.desktop 		         || true
	rm --force $(PWD)/build/Boilerplate.AppDir/*.png 		  	         || true
	rm --force $(PWD)/build/Boilerplate.AppDir/*.svg 		  	         || true
	rm --force $(PWD)/build/Boilerplate.AppDir/wpsoffice/libstdc++.so.6*  || true
	rm --force $(PWD)/build/Boilerplate.AppDir/lib64/libstdc++.so.6*      || true

	cp --force $(PWD)/AppDir/*.desktop 			$(PWD)/build/Boilerplate.AppDir/ || true
	cp --force $(PWD)/AppDir/*.svg 				$(PWD)/build/Boilerplate.AppDir/ || true

	export ARCH=x86_64 && $(PWD)/bin/appimagetool.AppImage $(PWD)/build/Boilerplate.AppDir $(PWD)/WPS-Office.AppImage
	chmod +x $(PWD)/WPS-Office.AppImage

init:
	mkdir --parents $(PWD)/bin

	wget https://apprepo.de/appimage/download/apprepo \
		--output-document=$(PWD)/bin/apprepo.AppImage
	chmod +x $(PWD)/bin/apprepo.AppImage

	wget https://github.com/AppImage/AppImageKit/releases/download/13/appimagetool-x86_64.AppImage \
		--output-document=$(PWD)/bin/appimagetool.AppImage
	chmod +x $(PWD)/bin/appimagetool.AppImage

clean:
	rm -rf $(PWD)/*.AppImage
	rm -rf $(PWD)/bin/*
	rm -rf $(PWD)/build
