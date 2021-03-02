# Not so mature script for getting configuration from GNS3 routers
import telnetlib
import time
from time import sleep


for i, port in enumerate(range(5000, 5008)):
    print(f"Connecting to router port {port}")
    router = telnetlib.Telnet('localhost', port)
    sleep(3)
    router_name = f'R{i+1}'
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
    with open(f"/Users/omriperi/GNS3_Config/{router_name}.txt", 'w') as file:
        file.write(running_string)




