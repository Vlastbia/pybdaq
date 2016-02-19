import bdaq
import random

def get_bits(x, n):
    """convert integer x into sequence of n bits"""
    for i in range(n):
        yield x&1
        x >>= 1

def main():
    # open the device
    instant_do = bdaq.InstantDoCtrl()

    instant_do.selected_device = bdaq.DeviceInformation(number=0)
    
    port_count = instant_do.port_count
    max_channels = instant_do.features.channel_count_max
    
    print('number of DO ports: {}'.format(port_count))    
    print('max. number of channels: {}'.format(max_channels))
    
    channels = int(max_channels/port_count)
    data = []
    for port in range(port_count):
        d = random.sample([True, False]*channels, channels)
        instant_do.write(d, start=port)
        data += [d]
        
    result = instant_do.read(start=0, count=port_count)
    print('data at all DO ports {}'.format(result))
    
    for d, r in zip(data, result):
        assert [bool(_) for _ in get_bits(r, channels)] == d
    
    print('test is successeful')

if __name__ == "__main__":
    main()
