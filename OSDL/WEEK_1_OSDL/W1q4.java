package WEEK_1_OSDL;

import java.util.Scanner;


public class W1q4 {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        Room myRoom = null; 

        System.out.print("Enter Room Number: ");
        int rNum = sc.nextInt();
        System.out.print("Enter Base Price: ");
        double bPrice = sc.nextDouble();

        System.out.println("\nSelect Room Type:");
        System.out.println("1. Standard Room");
        System.out.println("2. Luxury Room");
        int choice = sc.nextInt();

        if (choice == 1) {
            myRoom = new StandardRoom(rNum, bPrice);
        } else if (choice == 2) {
            myRoom = new LuxuryRoom(rNum, bPrice);
        } else {
            System.out.println("Invalid choice!");
            sc.close();
            return;
        }

        myRoom.displayRoomDetails();
        System.out.println("Total Tariff: $" + myRoom.calculateTariff());

        if (myRoom instanceof Amenities) {
            ((Amenities) myRoom).provideWifi();
            ((Amenities) myRoom).provideBreakfast();
        }

        sc.close();
    }
}

interface Amenities {
    void provideWifi();
    void provideBreakfast();
}
abstract class Room {
    protected int roomNumber;
    protected double basePrice;

    public Room(int roomNumber, double basePrice) {
        this.roomNumber = roomNumber;
        this.basePrice = basePrice;
    }

    public abstract double calculateTariff();

    public void displayRoomDetails() {
        System.out.println("Room Number: " + roomNumber);
        System.out.println("Price: $" + basePrice);
    }
}
class StandardRoom extends Room implements Amenities {
    public StandardRoom(int roomNumber, double basePrice) {
        super(roomNumber, basePrice);
    }

    @Override
    public double calculateTariff() {
        return basePrice * 1.05; 
    }

    public void provideWifi() {
        System.out.println("Wifi: Basic speed");
    }

    public void provideBreakfast() {
        System.out.println("Breakfast: Available at the cafe");
    }
}
class LuxuryRoom extends Room implements Amenities {
    public LuxuryRoom(int roomNumber, double basePrice) {
        super(roomNumber, basePrice);
    }

    @Override
    public double calculateTariff() {
        return (basePrice * 1.15) + 50.0;
    }

    public void provideWifi() {
        System.out.println("Wifi: High speed");
    }

    public void provideBreakfast() {
        System.out.println("Breakfast: Buffet included");
    }
}
