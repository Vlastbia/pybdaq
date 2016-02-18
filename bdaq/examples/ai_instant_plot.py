import time
import bdaq
import matplotlib.pyplot as pl
import matplotlib.animation as animation

class MyDevice:

    def __init__(self):
        self.device_name="DemoDevice,BID#0"
        print ("accessing device: {}".format(self.device_name))
        self.instant_ai = bdaq.InstantAiCtrl()
        self.instant_ai.selected_device = bdaq.DeviceInformation(number=0)
        
    def aquire(self, start_ch, ch_count, delay=0):
        scaled_data =self.instant_ai.read_scaled(start_ch, ch_count)
        time.sleep(delay)
        return scaled_data

def main():  
    device = MyDevice()  
    start_ch = 0
    ch_count = 3
    
    fig, ax = pl.subplots()
    lines = ax.plot([], [], [], [], [], [])
    ax.set_ylim(-11, 11)
    ax.set_xlim(0, 10)
    ax.grid()
    data = device.aquire(start_ch, ch_count)
    xdata, datas = [0], [[_] for _ in data]#*ch_count
    
    t0 = time.time()

    def run(data):
        # update the data
        dt = time.time() - t0
        xdata.append(dt)
        data = device.aquire(start_ch, ch_count)
        for yd, d in zip(datas, data):
            yd.append(d)
            
        xmin, xmax = ax.get_xlim()
    
        if dt >= xmax:
            ax.set_xlim(xmin, 2*xmax)
            ax.figure.canvas.draw()
        
        for yd, line in zip(datas, lines):
            line.set_data(xdata, yd)
    
        return lines

    ani = animation.FuncAnimation(fig, run, blit=True, interval=100,
                                  repeat=False)
                                  
    pl.show()

if __name__ == "__main__":
    main()
