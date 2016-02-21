import bdaq
import random

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
        assert bdaq.unpack_bits(r) == d

    print('test is successeful')

if __name__ == "__main__":
    main()
