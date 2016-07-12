package example;

/**
 * Created by dean on 7/12/16.
 *
 */
import src.feelixapi.*;
import jssc.SerialPortException;
import jssc.SerialPort ;
import jssc.SerialPortList ;
import java.util.regex.* ;

public class Example {

    public static void feelixControlExample2() {
        String portName = "/dev/ttyACM1" ;
        SerialPort ardy = new SerialPort(portName) ;
        try {
            ardy.openPort() ;
            ardy.setParams(9600, 8, 1, 0) ;
        }catch (SerialPortException e) {
            System.out.println(e) ;
        }
        // Now that it's open, we can connect it to the API.
        FeelixApi controller = new FeelixApi(ardy) ;
        controller.start() ;
        int[] newVal = {1,1,1,1,1,1,1,1,1} ;
        controller.setPulse(newVal, 200,200) ;
        try {
            Thread.sleep(5000);
        }catch (InterruptedException e ){
            System.out.println(e) ;
        }
        controller.stopThread();
    }
    public static void feelixControlExample() {
        FeelixApi controller = new FeelixApi("/dev/ttyACM1", 9600) ;
        controller.start() ;
        int[] newVal = {1,1,1,1,1,1,1,1,1} ;
        controller.setPulse(newVal, 200,200) ;
        try {
            Thread.sleep(5000);
        }catch (InterruptedException e ){
            System.out.println(e) ;
        }
        controller.stopThread();
    }

    public static void feelixControlExampleTest() {
        FeelixApi controller = new FeelixApi();
        System.out.println("Starting the thread!");
        controller.start(); // this is for the thread.
        try{
            for (int i = 0; i < 10; i++) {
                int[] newVal = {i,i,i};
                controller.setPulse(newVal, 500,500) ;
                Thread.sleep(1000) ;
            }
        }catch (InterruptedException e){

        }
        // make sure the sucker is dead.
        controller.stopThread();
        System.out.println(controller.isAlive());

    }

    public static void serialwrite() {
        System.out.println("Connecting to the serial port...") ;
        SerialPort serialport = new SerialPort("/dev/ttyACM0");
        try {
            serialport.openPort() ;
            serialport.setParams(9600, 8,1,0);
            try {
                for (int i = 0; i < 10; i++) {
                    serialport.writeString("000000000");
                    Thread.sleep(1000);
                    serialport.writeString("111111111");
                    Thread.sleep(1000);
                }
            }catch (InterruptedException e){
                System.out.println(e) ;
            }
            System.out.println("Connected successfully");
        }catch (SerialPortException ex) {
            System.out.println(ex) ;
        }
    }

    public static void seriallist() {

        //Method getPortNames() returns an array of strings. Elements of the array is already sorted.
        String[] portNames = SerialPortList.getPortNames("/dev/", Pattern.compile("tty"));
        System.out.println("Printing out the ports!");
        System.out.println(portNames.length);
        for(int i = 0; i < portNames.length; i++){
            System.out.println(portNames[i]);
        }

    }
    public static void main(String[] args) {
        //feelixControlExampleTest();
        seriallist();
        feelixControlExample();
    }
}
