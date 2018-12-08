
DEST := $(if $(DEST),$(DEST),gate)
BOARD := "esp8266:esp8266:generic:FlashSize=2M"


LOCAL_C_SRCS    ?= $(wildcard *.c)
LOCAL_INO_SRCS  ?= $(wildcard *.ino)
LOCAL_SRCS      = $(LOCAL_C_SRCS) $(LOCAL_INO_SRCS)

all: compile

compile:
	docker run -ti -v $$(pwd):/build damonpetta/arduino-cli-esp8266 compile -b $(BOARD) $(LOCAL_SRCS) -o $(DEST).bin

usb:
	esptool.py  -p /dev/ttyUSB0 --baud 115200 \
		write_flash --flash_mode dout 0x0000 $(DEST).bin

curl:
	curl -v -F "image=@$(DEST).bin" $(DEST)/update

clean:
	rm *.bin *.elf
