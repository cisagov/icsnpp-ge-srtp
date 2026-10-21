redef GE_SRTP::tcp_ports += { 12345/tcp };

event zeek_init() &priority=-10
    {
    assert(12345/tcp in GE_SRTP::tcp_ports);
    assert(12345/tcp in likely_server_ports);
    }
