# @TEST-DOC: Verify default and custom TCP port registration with valid GE SRTP traffic.
# @TEST-EXEC: base64 -d $DIST/testing/files/ge_srtp_default_tcp.pcap.base64 > default.pcap
# @TEST-EXEC: base64 -d $DIST/testing/files/ge_srtp_custom_tcp.pcap.base64 > custom.pcap
# @TEST-EXEC: mkdir default unconfigured configured
# @TEST-EXEC: cd default && zeek -Cr ../default.pcap $PACKAGE
# @TEST-EXEC: zeek-cut id.resp_p srtp_type < default/ge_srtp_general.log | awk '$1 == "18245" && $2 == "Request" { found=1 } END { exit !found }'
# @TEST-EXEC: cd unconfigured && zeek -Cr ../custom.pcap $PACKAGE
# @TEST-EXEC: test ! -e unconfigured/ge_srtp_general.log
# @TEST-EXEC: cd configured && zeek -Cr ../custom.pcap $PACKAGE $DIST/testing/files/ge_srtp_custom_port.zeek
# @TEST-EXEC: zeek-cut id.resp_p srtp_type < configured/ge_srtp_general.log | awk '$1 == "12345" && $2 == "Request" { found=1 } END { exit !found }'
