#include <string>
#include <iostream>
#include <cstdio>
#include <stdio.h>
#include "serial/serial.h"
using std::vector ; 
using std::string ; 

//void enumerate_ports() {
//    vector<serial::PortInfo> devices_found = serial::list_ports();
//    vector<serial::PortInfo>::iterator iter = devices_found.begin() ; 
//    
//    while( iter != devices_found.end() ){
//        serial::PortInfo device = *iter++;
//        printf("(%s, %s, %s)\n", device.port.c_str(), device.description.c_str(),
//            device.hardware_id.c_str());
//    }
//
//}


int main() {
    
    int baud = 9600;
    string port = "/dev/cu.usbmodem1411"; 
    serial::Serial my_serial(port, baud, serial::Timeout::simpleTimeout(1000));
    printf("Is the serial port open?\n");
    if (my_serial.isOpen()){
        printf("Yup!\n");
    }else{
        printf("Nope!\n");
    } 

}
