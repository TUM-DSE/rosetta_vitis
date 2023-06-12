include ../Makefile.inc

TARGET=hw
# CFLAGS:=-I../utils -I$(XILINX_VIVADO)/include $(CFLAGS)
CFLAGS:=-I../utils -I$(XILINX_VIVADO)/include -I$(XILINX_HLS)/include $(CFLAGS)
LDFLAGS:=-L../utils -L../minizip -lCraftUtils $(LDFLAGS)

# HDR are pure headers
HDR=
# OBJ must include a .cpp and .h with same name
OBJ=Accel.o AccelSchedule.o AccelTest.o AccelPrint.o Dense.o InputConv.o
EXE=host.exe

all: $(EXE) emconfig.json bnn.xclbin 

# Rule for object files, each object must have a header
$(OBJ): %.o: %.cpp %.h
	$(CXX) -c $< -o $@ $(CFLAGS)

%.o: %.cpp
	$(CXX) -c $< -o $@ $(CFLAGS)

# Rule for executables
$(EXE): %.exe: %.o $(OBJ)
	g++ -Wall -g -std=c++11 $^ -o $@ \
	$(CFLAGS) $(LDFLAGS) \
	-I${XILINX_XRT}/include/ \
	-L${XILINX_XRT}/lib/ -lOpenCL -pthread -lrt -lstdc++

bnn.xo: Accel.cpp
	v++ -c -t ${TARGET} --config ../config/u280.cfg -k bnn --hls.pre_tcl opt.tcl -I./ ./Accel.cpp  -o bnn.xo 

bnn.xclbin: ./bnn.xo
	v++ -l -t ${TARGET} --config ../config/u280.cfg ./bnn.xo -o bnn.xclbin

emconfig.json:
	emconfigutil --platform xilinx_u280_gen3x16_xdma_1_202211_1 --nd 1



.PHONY: hls clean hlsclean
hls:
	vivado_hls hls.tcl

hlsclean:
	rm -rf hls.prj vivado_hls.log

clean: hlsclean
	rm -rf vadd* app.exe *json *csv *log *summary _x .run .Xil .ipcache *.jou
	rm -rf *xclbin* *xo
	rm -f *.o *.exe
