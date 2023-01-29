PROJ=$(shell basename $(shell pwd))
LIN=$(shell grep '^platform =' platformio.ini)
PLATFORM=$(shell echo ${LIN} | cut -d "=" -f2- | tr -d '[:space:]' )

DEST=pharmdata.ddns.net

all: push

clean:
	pio run --target clean

mkdir:
	echo "ssh ${DEST} \"mkdir -p /var/www/html/firmware/${PLATFORM}/${PROJ}\""
	ssh ${DEST} \"mkdir -p /var/www/html/firmware/${PLATFORM}/${PROJ}\"

push:
	echo "PROJ: ${PROJ}"
	echo "LIN: ${LIN}"
	echo "PLATFORM: ${PLATFORM}"
	pio run
	scp .pio/build/esp32dev/firmware.bin ${DEST}:/var/www/html/firmware/${PLATFORM}/${PROJ}/firmware.bin

upload:
	pio run --target upload

monitor:
	pio device monitor

mu: upload monitor




