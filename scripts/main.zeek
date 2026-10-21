##! Copyright (c) 2024 Battelle Energy Alliance, LLC.
##!
##! main.zeek
##!
##! ICSNPP-GE_SRTP
##!
##! Zeek script type/record definitions describing the information
##! that will be written to the log files.


module GE_SRTP;

export {
    redef enum Log::ID += { LOG_GENERAL_LOG };

    ## TCP ports whose traffic is passed directly to the GE SRTP analyzer.
    const tcp_ports: set[port] = { 18245/tcp } &redef;

   # Log policies for log filtering
    global log_policy_general: Log::PolicyHook;

    global log_general_log: event(rec: general_log);
    global emit_ge_srtp_general_log: function(c: connection);

}

# redefine connection record to contain one of each of the ge_srtp records
redef record connection += {
    ge_srtp_proto: string &optional;
    ge_srtp_general_log: general_log &optional;
};

#Put protocol detection information here
event zeek_init() &priority=5 {
    # This helps Zeek identify the server endpoint. It does not register the
    # protocol analyzer; registration happens explicitly below.
    for ( p in tcp_ports )
        add likely_server_ports[p];

    Analyzer::register_for_ports(Analyzer::ANALYZER_SPICY_GE_SRTP_TCP,
                                 tcp_ports);

    # initialize logging streams for all ge_srtp logs
                      Log::create_stream(GE_SRTP::LOG_GENERAL_LOG,
                      [$columns=general_log,
                      $ev=log_general_log,
                      $path="ge_srtp_general",
                      $policy=log_policy_general]);
}

function emit_ge_srtp_general_log(c: connection) {
    if (! c?$ge_srtp_general_log )
        return;
    if ( c?$ge_srtp_proto )
        c$ge_srtp_general_log$proto = c$ge_srtp_proto;
    Log::write(GE_SRTP::LOG_GENERAL_LOG, c$ge_srtp_general_log);
    delete c$ge_srtp_general_log;
}
