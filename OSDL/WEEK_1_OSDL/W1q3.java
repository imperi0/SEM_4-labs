package WEEK_1_OSDL;

import WEEK_1_OSDL.q3class.StandardRoom;

import WEEK_1_OSDL.q3class.Room;
import WEEK_1_OSDL.q3class.LuxuryRoom;

import java.util.Scanner;

public class W1q3 {

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        System.out.println("Enter room type (1 : Standard, 2 : Luxury): ");
        int roomType = scanner.nextInt();

        System.out.print("Enter the room number: ");
        int roomNumber = scanner.nextInt();

        System.out.print("Enter the base tariff for the room: ");
        double baseTariff = scanner.nextDouble();

        Room room = null;

        if (roomType == 1) {
            System.out.print("Enter the AC charges for the Standard Room: ");
            double acCharges = scanner.nextDouble();
            room = new StandardRoom(roomNumber, baseTariff, acCharges);
        } else if (roomType == 2) {
            System.out.print("Enter the AC charges for the Luxury Room: ");
            double acCharges = scanner.nextDouble();

            System.out.print("Enter the extra amenities charges: ");
            double extraAmenities = scanner.nextDouble();

            System.out.print("Enter the premium services charges: ");
            double premiumServices = scanner.nextDouble();

            room = new LuxuryRoom(roomNumber, baseTariff, acCharges, extraAmenities, premiumServices);
        } else {
            System.out.println("Invalid room type selected.");
            scanner.close();
            return;
        }

        System.out.println("The total price for room number " + roomNumber + " is: " + room.calculateTariff());

        scanner.close();
    }
}
