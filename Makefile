SOURCE="http://wdl1.pcfg.cache.wpscdn.com/wpsdl/wpsoffice/download/linux/9505/wps-office_11.1.0.9505.XA_amd64.deb"
DESTINATION="build.deb"
OUTPUT="WPS-Office.AppImage"

all:
	echo "Building: $(OUTPUT)"
	echo "Building: $(OUTPUT)"
	wget --output-document=$(DESTINATION)  --continue $(SOURCE)
	dpkg -x $(DESTINATION) build

	rm -rf AppDir/opt
	mkdir --parents AppDir/opt/application
	cp -r build/opt/kingsoft/wps-office/office6/* AppDir/opt/application

	chmod +x AppDir/AppRun

	export ARCH=x86_64 && bin/appimagetool.AppImage AppDir $(OUTPUT)

	chmod +x $(OUTPUT)

	rm -f $(DESTINATION)
	rm -rf AppDir/opt
	rm -rf build
