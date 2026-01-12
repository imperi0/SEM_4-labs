package WEEK_1_OSDL;

import java.util.Scanner;

import WEEK_1_OSDL.q2class.DeluxeRoom;
import WEEK_1_OSDL.q2class.Room;

public class W1q2 {
    public static void main(String[] args) {
        Scanner input = new Scanner(System.in);

        System.out.println(" Room Input (fro 2 parameter constructor)");
        System.out.print(" Room Number : ");
        int r1Num = input.nextInt();
        input.nextLine();
        System.out.print(" Room Type : ");
        String r1Type = input.nextLine();

        Room standardRoom = new Room(r1Num, r1Type);

        System.out.println(" Deluxe Room Input  ");
        System.out.print(" Room Number : ");
        int r2Num = input.nextInt();
        input.nextLine();
        System.out.print(" Room Type : ");
        String r2Type = input.nextLine();
        System.out.print(" Base Price : ");
        double r2Price = input.nextDouble();
        System.out.print(" WiFi Available? (true/false): ");
        boolean r2Wifi = input.nextBoolean();
        System.out.print(" Breakfast Complimentry? (true/false): ");
        boolean r2Bfast = input.nextBoolean();

        DeluxeRoom deluxeRoom = new DeluxeRoom(r2Num, r2Type, r2Price, r2Wifi, r2Bfast);
        
        System.out.println(" Room object :");
        System.out.println("Number: " + standardRoom.roomNumber + ", Type: " + standardRoom.roomType + ", Price: " + standardRoom.basePrice);

        System.out.println(" Deluxe room object 2 :");
        System.out.println("Number: " + deluxeRoom.roomNumber + ", Type: " + deluxeRoom.roomType + ", Price: " + deluxeRoom.basePrice);
        System.out.println("WiFi: " + deluxeRoom.wifiAvail + ", Breakfast: " + deluxeRoom.complBfast);

        input.close();
    }
}