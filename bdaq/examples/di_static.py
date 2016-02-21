import bdaq

def main():
    # open the device
    instant_di = bdaq.InstantDiCtrl()

    instant_di.selected_device = bdaq.DeviceInformation(number=0)

    port_count = instant_di.port_count
    max_channels = instant_di.features.channel_count_max
    data_mask = instant_di.features.data_mask
    di_int_of_channels = instant_di.features.di_int_of_channels
    di_cos_int_of_ports = instant_di.features.di_cos_int_of_ports
    noise_filter_supported = instant_di.features.noise_filter_supported
    scan_count_max = instant_di.features.scan_count_max
    sampling_method = instant_di.features.sampling_method
    scan_clock_range = instant_di.features.scan_clock_range
    trigger_delay_range = instant_di.features.trigger_delay_range

    print('number of DI ports: {}'.format(port_count))
    print('max. number of channels: {}'.format(max_channels)) # simple property
    print('noise_filter_supported: {}'.format(noise_filter_supported)) # simple property
    print('scan_count_max: {}'.format(scan_count_max)) # simple property
    print('data mask: {}'.format(data_mask)) # collection of ints
    print('di_int_of_channels: {}'.format(di_int_of_channels)) # collection of ints
    print('di_cos_int_of_port: {}'.format(di_cos_int_of_ports)) # collection of ints
    print('sampling_method: {}'.format(sampling_method)) # enum
    print('scan_clock_range: {}'.format(scan_clock_range)) # math interval7
    print('trigger_delay_range: {}'.format(trigger_delay_range)) # math interval
    print()

    result = instant_di.read(start=0, count=port_count)
    print('data at all DI ports {}'.format(result))

    for r in result:
        print(bdaq.unpack_bits(r))

    print('test is successeful')

if __name__ == "__main__":
    main()
