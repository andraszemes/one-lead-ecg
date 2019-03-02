# One Lead ECG

The objective of this project was to create a working single lead EKG. The work process was divided into several stages to provide clarity and a productive development framework. Firstly, the hardware had to be layed out, manufactured and constructed. Then followed the phase of software design, development and deployment on different application layers. The finished product encompasses both physical and intellectual components.

The device measures biopotentials using body-surface electrodes. After amplification the signal is processed and filtered by a programmable microchip. Next, the filtered data gets transferred into the computer, where a program plots out the resulting graph. The input stream can be saved for later use either as a visual snapshot or as a data file.

A lot can be learned from such a comprehensive, theoretically and practically challanging undertaking. Let the subject of this project be a testimony to the importance of interdisciplinary research and exchange of knowledge.

## Hardware

The circuit schematic and PCB design is available in the /hardware folder. The design files were created in Eagle.

### Prerequisites

For the desktop application make sure the Java Runtime Environment is installed.

## Web interface demo

The web interface is currently available on [the demo site](http://ekg.epizy.com/).

### Desktop app installation

The distribution binaries are located in /software/heart_rate_monitor/dist. Alternatively you can use the Serial Plotter of the Arduino IDE.

Linux terminal:

```
./heart_rate_monitor
```

Windows CLI:

```
heart_rate_monitor.exe
```

## Built With

* [Arduino IDE](https://www.arduino.cc/en/main/software) - Microchip programming
* [Eagle](https://www.autodesk.com/products/eagle/overview) - PCB design software
* [Processing](https://processing.org/) - Visual desktop application
* [Bootstrap](https://getbootstrap.com/) - The web framework used
* [CanvasJS](https://canvasjs.com/) - Graph plotting API on the web

## Authors

* **András Zemes** - *Project developer* - [andraszemes](https://github.com/andraszemes)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* [Scott W harden](https://www.swharden.com/wp/)
* [Casey Kuhns](https://github.com/sparkfun/AD8232_Heart_Rate_Monitor)
* [Pieter Pas](https://github.com/tttapa/Filters)

