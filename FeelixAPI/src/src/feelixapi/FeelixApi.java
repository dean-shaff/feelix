package src.feelixapi;

/**
 * Created by dean on 7/12/16.
 */


import java.util.Arrays;
import jssc.SerialPort ;
import jssc.SerialPortException;

public class FeelixApi extends Thread{

    private int[] zeroVal = {0,0,0,0,0,0,0,0,0};
    private int[] curVal = {0,0,0,0,0,0,0,0,0};
    private boolean isRunning = true ;
    private boolean finishedSending = false;
    int onTime = 100;
    int offTime = 100;
    private boolean test ;

    int[] ardyPins ;
    SerialPort arduino  ; // Assumes you've already set up the serial port

    public FeelixApi(SerialPort arduino){
        /**
         Constructor for use with a serial connection. Uses jssc serialport for connection.
         Assumes that you've already opened the connection.
         */
        this.arduino = arduino;
        this.test = false;
    }

    public FeelixApi(String portName, int baudRate) {
        /**
         Constructor if you don't want to set up the serial connection outside of the api.
         */
        SerialPort arduino = new SerialPort(portName) ;
        try {
            arduino.openPort();
            arduino.setParams(baudRate, 8, 1, 0);
            this.arduino = arduino ;
        } catch (SerialPortException ex) {
            System.out.println(ex) ;
            stopThread();
        }
        this.test = false;

    }

    public FeelixApi(){
        /**
        Constructor for testing purposes -- if we don't pass a SerialPort instance
         then we're testing without a serial port.
        */
        this.test = true;
    }


    public void setCurVal(int[] newVal){
        this.curVal = Arrays.copyOf(newVal, newVal.length);
    }

    public void setPulse(int[] newVal, int onTime, int offTime) {
        /**
         * Set the current value, and the on/off time for the pulse. This gets continually sent
         * to the serial port / command line in the run function.
         */
        this.onTime = onTime ;
        this.offTime = offTime ;
        this.curVal = Arrays.copyOf(newVal, newVal.length) ;

    }

    private String arrToString(int[] arr) {
        String newString = "";
        for (int i=0; i<arr.length; i ++ ){
            newString += arr[i] ;
        }
        return newString ;
    }

    public void writeVal(int[] arr){
        /**
         * Write to the serial port/command line.
         * args:
         * arr - an array of ints that gets send to the command line/ serial port .
          */
        if (this.test) {
            String arrString = arrToString(arr) ;
            System.out.println(arrString) ;
        } else if (! this.test) {
            // means we've have an open serial connection.
            String arrString = arrToString(arr) ;
            try {
                this.arduino.writeString(arrString);
                System.out.println(arrString) ;
            }catch (SerialPortException ex) {
                System.out.println(ex) ;
            }
        }


    }
    public void run(){
        while (this.isRunning) {
            try {
                System.out.println("On Value:");
                writeVal(this.curVal);
                System.out.print("\n");
                Thread.sleep(onTime);

                System.out.println("Off Value:");
                writeVal(this.zeroVal);
                System.out.print("\n");
                Thread.sleep(offTime) ;
            }catch (InterruptedException e){
                System.out.println(e) ;
            }
        }
    }
    public void stopThread(){
        try {
            this.isRunning = false;
            this.join() ;
        } catch (InterruptedException ex ){
            System.out.println(ex) ;
        }
    }
}


