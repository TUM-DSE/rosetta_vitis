PRJ_NAME=spam_filter
SRC_DIR=../src

all: app.exe emconfig.json $(PRJ_NAME).xclbin

app.exe: $(SRC_DIR)/host_u280.cpp
	g++ -Wall -g -std=c++11 $(SRC_DIR)/host_u280.cpp -o app.exe \
		-I${XILINX_XRT}/include/ \
		-I${XILINX_VIVADO}/include/ \
		-I${XILINX_HLS}/include/ \
		-L${XILINX_XRT}/lib/ -lOpenCL -pthread -lrt -lstdc++
	
$(PRJ_NAME).xo: $(SRC_DIR)/$(PRJ_NAME).cpp
	v++ -c -t ${TARGET} --config $(SRC_DIR)/u280_ddr.cfg -k $(PRJ_NAME) -I${XILINX_VIVADO}/include/ -I$(SRC_DIR)/ $(SRC_DIR)/$(PRJ_NAME).cpp -o $(PRJ_NAME).xo 

$(PRJ_NAME).xclbin: ./$(PRJ_NAME).xo
	v++ -l -t ${TARGET} --config $(SRC_DIR)/u280_ddr.cfg ./$(PRJ_NAME).xo -o $(PRJ_NAME).xclbin

emconfig.json:
	emconfigutil --platform xilinx_u280_gen3x16_xdma_1_202211_1 --nd 1

clean:
	rm -rf $(PRJ_NAME)* app.exe *json *csv *log *summary _x xilinx* .run .Xil .ipcache *.jou

# Unless specified, use the current directory name as the v++ build target
TARGET ?= $(notdir $(CURDIR))
