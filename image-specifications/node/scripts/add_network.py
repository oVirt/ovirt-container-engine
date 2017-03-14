#!/bin/python
from vdsm import vdscli
import os
import socket

c = vdscli.connect()
network_attrs = {'nic': 'veth_name0',
                 'ipaddr': socket.gethostbyname(socket.gethostname()),
                 'netmask': '255.240.0.0',
                 'gateway': os.environ['CLUSTER_GATEWAY'],
                 'defaultRoute': True,
                 'bridged': True}

c.setupNetworks({'ovirtmgmt': network_attrs}, {}, {'connectivityCheck': False})
