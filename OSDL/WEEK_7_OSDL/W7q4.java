package WEEK_7_OSDL;

public class W7q4 {

    public static <T> void printArray(T[] array) {
        for (T element : array) {
            System.out.println(element);
        }
    }

    public static void main(String[] args) {

        Integer[] roomNumbers = {101, 102, 103, 104};
        String[] roomTypes = {"Deluxe", "Suite", "Standard", "Executive"};
        Double[] roomPrices = {199.99, 299.99, 149.99, 249.99};

        System.out.println("Room Numbers:");
        printArray(roomNumbers);

        System.out.println("Room Types:");
        printArray(roomTypes);

        System.out.println("Room Prices:");
        printArray(roomPrices);
    }
}

/* 
package WEEK_7_OSDL;

import java.util.Scanner;

public class W7q4 {

    public static <T> void printArray(T[] array) {
        for (T element : array) {
            System.out.println(element);
        }
        System.out.println("---------------------------");
    }

    public static void main(String[] args) {

        Scanner sc = new Scanner(System.in);

        System.out.print("Enter number of rooms: ");
        int n = sc.nextInt();
        sc.nextLine();

        Integer[] roomNumbers = new Integer[n];
        String[] roomTypes = new String[n];
        Double[] roomPrices = new Double[n];

        for (int i = 0; i < n; i++) {
            System.out.print("Enter room number for room " + (i + 1) + ": ");
            roomNumbers[i] = sc.nextInt();
            sc.nextLine();

            System.out.print("Enter room type for room " + (i + 1) + ": ");
            roomTypes[i] = sc.nextLine();

            System.out.print("Enter room price for room " + (i + 1) + ": ");
            roomPrices[i] = sc.nextDouble();
            sc.nextLine();
        }

        System.out.println("\nRoom Numbers:");
        printArray(roomNumbers);

        System.out.println("Room Types:");
        printArray(roomTypes);

        System.out.println("Room Prices:");
        printArray(roomPrices);

        sc.close();
    }
}
*/