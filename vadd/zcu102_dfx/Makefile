
all: package/sd_card.img

app.exe: ../src/host.cpp
	${CXX} -Wall -g -std=c++11 ../src/host.cpp -o app.exe \
		-I/usr/include/xrt \
		-I${XILINX_VIVADO}/include \
		-lOpenCL \
		-lpthread \
		-lrt \
		-lstdc++

${kl_name}.xo: ../src/${kl_name}.cpp ../src/zcu102_dfx.cfg
	v++ -c -t hw --config ../src/zcu102_dfx.cfg -k ${kl_name} -I../src -I${XILINX_VIVADO}/include ../src/${kl_name}.cpp -o ${kl_name}.xo 

${kl_name}.xclbin: ./${kl_name}.xo
	v++ -l -t hw --config ../src/zcu102_dfx.cfg ./${kl_name}.xo \
		--vivado.synth.jobs $(MaxJobNum) \
		--vivado.impl.jobs $(MaxJobNum) \
		-o ${kl_name}.xclbin

package/sd_card.img: app.exe ${kl_name}.xclbin xrt.ini run_app.sh
	v++ -p -t hw --config ../src/zcu102_dfx.cfg ./${kl_name}.xclbin \
		--package.out_dir package \
		--package.rootfs ${ROOTFS}/rootfs.ext4 \
		--package.sd_file ${ROOTFS}/Image \
		--package.sd_file ${kl_name}.xclbin \
		--package.sd_file xrt.ini \
		--package.sd_file app.exe \
		--package.sd_file run_app.sh


clean:
	rm -rf *xclbin* app.exe *json *xo *csv *log *summary _x package *.json .run .Xil .ipcache *.jou

# Unless specified, use the current directory name as the v++ build target
TARGET ?= $(notdir $(CURDIR))
