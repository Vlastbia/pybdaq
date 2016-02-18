import time
import bdaq
#import matplotlib.pyplot as pl

def main(device_name="DemoDevice,BID#0", start=1, count=1):
    # set up the device
    print ("accessing device: {}".format(device_name))

    instant_ai = bdaq.InstantAiCtrl()

    instant_ai.selected_device = bdaq.DeviceInformation(number=0)

    print("starting acquisition")

    count_max = count
    
    for i in range(50):
        scaled_data = instant_ai.read_scaled(start, count)

        for i, value in enumerate(scaled_data):
            print("channel {} data: {:10.6f}".format((i + start) % count_max, value))

        time.sleep(0.2)

if __name__ == "__main__":
    main()
