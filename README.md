### Feelix API 

## Usage 

You can initialize the API in three ways. First, you can initialize a testing mode, where the API doesn't actually connect to a serial port. Do this as follows. 
```java
import src.feelixapi.FeelixApi ; 
FeelixApi controller = new FeelixApi();
```
Now if you want to actually connect to a serial port, you can either pass it the open serial connection, or have the API do it itself. This part is dependent on jssc, or java simple serial connection. This serial library is seriously awesome, and is used in Processing. Make sure you have access to the serial ports on your computer, or else it won't work.  
```java
import src.feelixapi.FeelixApi ; 
import jssc.SerialPort ; 
import jssc.SerialPortException ; 
import jssc.SerialPortList ; 

String[] portNames = SerialPortList.getPortNames() ; // should work for ports in "/dev/" 

String portName = "/dev/tty1"; // Or whatever it might be 
// or do the following 
String portName = portNames[0] ; 
int baudRate = 9600 ; 
SerialPort arduino = new SerialPort(portName);

try { 
	arduino.openPort();
	arduino.setParams(baudRate, 8, 1, 0) ;
} catch (SerialPortException e) {
	System.out.println(e); 
} 

FeelixApi controller = new FeelixApi(arduino) ; 

// or simply just pass it the portname and baudrate ; 

FeelixApi controller = new FeelixApi(portName, baudRate) ; 
```
There are only a few main functions of concern when sending signals to the arduino. 
```java
controller.start() ; // start the API's thread. 
int[] newVal = {1,1,1,1,1,1,1,1,1} ; // Means that all the pins will be firing 
controller.setPulse(newVal, 200, 200) ; // fire all pins, 200 ms on, 200 ms off.  
// other stuff ...
controller.stopThread() ; // this stops the thread. 
```

