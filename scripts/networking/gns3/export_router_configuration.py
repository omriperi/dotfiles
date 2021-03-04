# Not so mature script for getting configuration from GNS3 routers
import telnetlib
import time
from time import sleep
import argparse

BASE_PORT_NUMBER = 5000
BASE_PORT_NUMBER_RELATED_TO_R = BASE_PORT_NUMBER - 1

parser = argparse.ArgumentParser(description='Invoking GNS app')

parser.add_argument('-r', '--routers', action="store", dest="routers", type=str)
routers = parser.parse_args().routers

if '-' in routers:
    router_list = range(int(routers[0]), int(routers[-1])+1)
else:
    router_list = [int(routers)]

print(f'Routers to run on are {router_list}')

for router_id in router_list:
    port = BASE_PORT_NUMBER_RELATED_TO_R + router_id
    router_name = f'R{router_id}'

    print(f"Connecting to router router name {router_name} port {port}")
    router = telnetlib.Telnet('localhost', port)
    sleep(3)
    router.read_very_eager()
    router.write(b"\r")
    time.sleep(0.2)
    terminal = router.read_very_eager().decode()
    print(f'Terminal is {terminal}')
    if '(' in terminal:
        print("Router in config mode")
        cmd_prefix = 'do '
    else:
        print("Router in view mode")
        cmd_prefix = ''

    router.write(f"{cmd_prefix} terminal length 0\r".encode())
    sleep(0.1)
    router.read_very_eager()

    print("Getting the running string")
    router.write(f"{cmd_prefix} show running\r".encode())
    sleep(5)
    running = router.read_very_eager()
    running_string = running.decode()
    
    # Manipulating running string so all the interfaces are up by default, 
    # since shutdown is by default we should do "no shut"\
    fixed_running_config = []
    for conf_line in running_string.splitlines():
        fixed_running_config.append(conf_line)
        if conf_line.startswith("interface"):
            fixed_running_config.append("  no shut")

    running_string = '\n'.join(fixed_running_config)
    with open(f"/Users/omriperi/GNS3_Config/{router_name}.txt", 'w') as file:
        file.write(running_string)




