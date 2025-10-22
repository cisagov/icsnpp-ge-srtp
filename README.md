# Build Status

| Source       | `main` Status | `main` Timestamp |
|--------------|--------------|------------|
| **CISAGOV** | ![Build Status](https://img.shields.io/badge/dynamic/json?url=https%3A%2F%2Fapi.github.com%2Frepos%2Fcisagov%2Ficsnpp-ge-srtp%2Fcommits%2Fmain%2Fstatus&query=state&label=build) | ![Last Build](https://img.shields.io/badge/dynamic/json?url=https%3A%2F%2Fapi.github.com%2Frepos%2Fcisagov%2Ficsnpp-ge-srtp%2Fcommits%2Fmain%2Fstatus&query=statuses[0].updated_at&label=last%20build&color=lightgrey) |
| **Development** | ![Build Status](https://img.shields.io/badge/dynamic/json?url=https%3A%2F%2Fapi.github.com%2Frepos%2Fparsitects%2Ficsnpp-ge-srtp%2Fcommits%2Fmain%2Fstatus&query=state&label=build) | ![Last Build](https://img.shields.io/badge/dynamic/json?url=https%3A%2F%2Fapi.github.com%2Frepos%2Fparsitects%2Ficsnpp-ge-srtp%2Fcommits%2Fmain%2Fstatus&query=statuses[0].updated_at&label=last%20build&color=lightgrey) |

# ICSNPP-GE-SRTP 

Industrial Control Systems Network Protocol Parsers (ICSNPP) - GE SRTP

## Overview

ICSNPP-GE-SRTP is a Zeek plugin (written in [Spicy](https://docs.zeek.org/projects/spicy/en/latest/)) for parsing and logging fields used by the GE SRTP protocol, as defined in [Leveraging the SRTP protocol for over-the-network memory acquistion of a GE Fanuc Seris 90-30](reference-docs/Leveraging%20the%20SRTP%20Protocol%20for%20Over-the-Network%20Memory%20Acquisition%20of%20a%20GE%20Fanuc%20Series%2090-30.pdf)

This parser produces the following log files, defined in [scripts/main.zeek](scripts/main.zeek):

* `ge_srtp_general.log`

For additional information on this log file, see the *Logging Capabilities* section below.

## Installation

### Package Manager

This script is available as a package for [Zeek Package Manager](https://docs.zeek.org/projects/package-manager/en/stable/index.html). It requires [Spicy](https://docs.zeek.org/projects/spicy/en/latest/) and the [Zeek Spicy plugin](https://docs.zeek.org/projects/spicy/en/latest/zeek.html).

```bash
$ zkg refresh
$ zkg install icsnpp-ge-srtp
```

If this package is installed from ZKG, it will be added to the available plugins. This can be tested by running `zeek -NN`. If installed correctly, users will see `[Analyzer] spicy_GE_SRTP_TCP (ANALYZER_SPICY_GE_SRTP_TCP, enabled)` under the list of `Zeek::Spicy` analyzers.

If users have ZKG configured to load packages (see `@load packages` in the [ZKG Quickstart Guide](https://docs.zeek.org/projects/package-manager/en/stable/quickstart.html)), this plugin and these scripts will automatically be loaded and ready to go.

## Logging Capabilities

### GE SRTP Log (ge_srtp_general.log)

#### Overview

This log summarizes, by connection, GE SRTP frames transmitted to `ge_srtp_general.log`.

#### Fields Captured

| Field                     | Type            | Description                                                                            |
| --------------------------|-----------------|----------------------------------------------------------------------------------------|
| ts                        | time            | Timestamp (network time)                                                               |
| uid                       | string          | Uinque ID for this connection                                                          |
| id                        | conn_id         | Default Zeek connection info (IP Addresses, Ports, etc.)                               |
| proto                     | string          | Transport protocol                                                                     |
| srtp_type                 | string          | Type: Request (0x02) Reply (0x03)                                                      |
| sequence_number_1         | count           | Sequence number identifying request/reply pairs.  Repeated twice in message structure. |
| text_length               | count           | Length of the message for messages greater than 56 bytes                               |
| time_seconds              | count           | Time in seconds                                                                        |
| time_minutes              | count           | Time in minutes                                                                        |
| time_hours                | count           | Time in hours                                                                          | 
| sequence_number_2         | count           | Second sequence number                                                                 |
| message_type              | string          | Message type                                                                           |
| mailbox_source            | count           | Mailbox source                                                                         |
| mailbox_destination       | count           | Mailbox destination                                                                    |
| packet_number             | count           | Packet number                                                                          |
| total_packet_number       | count           | Total packet number                                                                    |
| service_request_code      | string          | Service request code based on the type of memory being requested                       |
| segment_selector          | string          | Segment selector determining which memory register is accessed                         |
| memory_offset             | count           | Memory offset starting with zero                                                       |
| data_length               | count           | Data length for the memory type accessed.                                              |
| status_code               | string          | Status code                                                                            |
| minor_status_code         | string          | Minor status code                                                                      |
| data_requested            | string          | Data requested                                                                         |
| control_program_number    | count           | The number of the control program task the master is currently logged into.            |
| current_privilege_level   | count           | Current privilege level of the master device                                           |
| last_sweep_time           | count           | The last elapsed time to fully execute program task.                                   |
| oversweep_flag            | string          | Oversweep flag.  Meaningful only if constant sweep mode is active                      |
| constant_sweep_mode       | string          | Constant sweep mode. Active (0x01); Not Active (0x00)                                  |
| plc_fault_entry_last_read | string          | PLC Fault Entry since last read.                                                       |
| io_fault_entry_last_read  | string          | I/O Falut Entry since last read.                                                       |
| plc_fault_entry_present   | string          | PLC Fault Entry present.                                                               |
| io_fault_entry_present    | string          | I/O Fault Entry present.                                                               |
| programmer_attachment     | string          | Programmer attachement flag.  Attachment found (0x01); No Attachement found (0x00)     |
| front_panel_enable_switch | string          | Front panel ENABLE/DISABLE switch setting.                                             |
| front_panel_run_switch    | string          | Front panel RUN/STOP switch setting.                                                   |
| oem_protected             | string          | OEM protected bit.                                                                     |
| plc_state                 | string          | PLC State                                                                              |

## ICSNPP Packages

All ICSNPP Packages:
* [ICSNPP](https://github.com/cisagov/icsnpp)

Full ICS Protocol Parsers:
* [BACnet](https://github.com/cisagov/icsnpp-bacnet)
    * Full Zeek protocol parser for BACnet (Building Control and Automation)
* [BSAP](https://github.com/cisagov/icsnpp-bsap)
    * Full Zeek protocol parser for BSAP (Bristol Standard Asynchronous Protocol) over IP
    * Full Zeek protocol parser for BSAP Serial comm converted using serial tap device
* [Ethercat](https://github.com/cisagov/icsnpp-ethercat)
    * Full Zeek protocol parser for Ethercat
* [Ethernet/IP and CIP](https://github.com/cisagov/icsnpp-enip)
    * Full Zeek protocol parser for Ethernet/IP and CIP
* [Genisys](https://github.com/cisagov/icsnpp-genisys)
    * Full Zeek protocol parser for Genisys
* [OPCUA-Binary](https://github.com/cisagov/icsnpp-opcua-binary)
    * Full Zeek protocol parser for OPC UA (OPC Unified Architecture) - Binary
* [S7Comm](https://github.com/cisagov/icsnpp-s7comm)
    * Full Zeek protocol parser for S7comm, S7comm-plus, and COTP
* [Synchrophasor](https://github.com/cisagov/icsnpp-synchrophasor)
    * Full Zeek protocol parser for Synchrophasor Data Transfer for Power Systems (C37.118)
* [Profinet IO CM](https://github.com/cisagov/icsnpp-profinet-io-cm)
    * Full Zeek protocol parser for Profinet I/O Context Manager

Updates to Zeek ICS Protocol Parsers:
* [DNP3](https://github.com/cisagov/icsnpp-dnp3)
    * DNP3 Zeek script extending logging capabilities of Zeek's default DNP3 protocol parser
* [Modbus](https://github.com/cisagov/icsnpp-modbus)
    * Modbus Zeek script extending logging capabilities of Zeek's default Modbus protocol parser

### License

Copyright 2023 Battelle Energy Alliance, LLC. Released under the terms of the 3-Clause BSD License (see [`LICENSE.txt`](./LICENSE.txt)).
~

