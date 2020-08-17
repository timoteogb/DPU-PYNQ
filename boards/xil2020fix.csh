#!/bin/csh
alias cadman 'eval `/tools/xint/prod/bin/cad.pl \!*`';
echo "Changing to 2020.1 tools..."
cadman add -t xilinx -v 2020.1_released
echo "Regenerating xclbin file..."

xclbinutil --add-section BITSTREAM:RAW:./ZCU104/binary_container_1/link/int/system.bit \
--force --key-value SYS:mode:flat --add-section :JSON:./ZCU104/binary_container_1/link/int/dpu.rtd \
--add-section CLOCK_FREQ_TOPOLOGY:JSON:./ZCU104/binary_container_1/link/int/dpu_xml.rtd \
--add-section BUILD_METADATA:JSON:./ZCU104/binary_container_1/link/int/dpu_build.rtd \
--add-section EMBEDDED_METADATA:RAW:./ZCU104/binary_container_1/link/int/dpu.xml \
--add-section SYSTEM_METADATA:RAW:./ZCU104/binary_container_1/link/int/systemDiagramModelSlrBaseAddress.json \
--key-value SYS:PlatformVBNV:xilinx_zcu104_zcu104_dpu_1_0 --output ./ZCU104/binary_container_1/link/int/dpu.xclbin

cp -f ./ZCU104/binary_container_1/link/vivado/vpl/prj/prj.srcs/sources_1/bd/zcu104_dpu/hw_handoff/zcu104_dpu.hwh ./ZCU104/dpu.hwh
cp -f ./ZCU104/binary_container_1/link/vivado/vpl/prj/prj.runs/impl_1/zcu104_dpu_wrapper.bit ./ZCU104/dpu.bit
cp -f ./ZCU104/binary_container_1/dpu.xclbin ./ZCU104/dpu.xclbin

echo "Done."
