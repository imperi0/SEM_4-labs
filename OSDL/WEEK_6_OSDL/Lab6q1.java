import java.io.*;
import java.util.Scanner;

public class W6q1 {

    static final int RECORD_SIZE = 53;  // 4 bytes for int, 20 * 2 bytes for string, 8 bytes for double, 1 byte for boolean

    // Write fixed length string
    public static void writeFixedString(String s, int length, RandomAccessFile raf) throws IOException {
        StringBuilder sb = new StringBuilder(s);
        sb.setLength(length);
        raf.writeChars(sb.toString());
    }

    // Read fixed length string
    public static String readFixedString(int length, RandomAccessFile raf) throws IOException {
        char[] chars = new char[length];
        for (int i = 0; i < length; i++)
            chars[i] = raf.readChar();
        return new String(chars).trim();
    }

    public static void main(String[] args) throws Exception {

        Scanner sc = new Scanner(System.in);
        RandomAccessFile raf = new RandomAccessFile("rooms.dat", "rw");

        while (true) {
            System.out.println("\n1.Add Room");
            System.out.println("2.View Room");
            System.out.println("3.Update Booking");
            System.out.println("4.Exit");

            int choice = sc.nextInt();

            if (choice == 1) {
                System.out.print("Room Number: ");
                int roomNo = sc.nextInt();
                sc.nextLine();  // Consume newline

                System.out.print("Room Type: ");
                String type = sc.nextLine();

                System.out.print("Price: ");
                double price = sc.nextDouble();

                System.out.print("Booking Status (true/false): ");
                boolean status = sc.nextBoolean();

                raf.seek(raf.length());  // Go to the end of the file to add a new room
                raf.writeInt(roomNo);
                writeFixedString(type, 20, raf);
                raf.writeDouble(price);
                raf.writeBoolean(status);

                System.out.println("Room Added!");
            }

            else if (choice == 2) {
                System.out.print("Enter Room Index (0-based): ");
                int index = sc.nextInt();

                // Check if the index is within the valid range
                if (index * RECORD_SIZE < raf.length()) {
                    raf.seek(index * RECORD_SIZE);

                    int roomNo = raf.readInt();
                    String type = readFixedString(20, raf);
                    double price = raf.readDouble();
                    boolean status = raf.readBoolean();

                    System.out.println("Room No: " + roomNo);
                    System.out.println("Type: " + type);
                    System.out.println("Price: " + price);
                    System.out.println("Booked: " + status);
                } else {
                    System.out.println("Invalid room index.");
                }
            }

            else if (choice == 3) {
                System.out.print("Enter Room Index to update: ");
                int index = sc.nextInt();

                // Check if the index is within the valid range
                if (index * RECORD_SIZE < raf.length()) {
                    raf.seek(index * RECORD_SIZE + 4 + 40 + 8); // Skip roomNo + type + price

                    System.out.print("New Booking Status: ");
                    boolean status = sc.nextBoolean();

                    raf.writeBoolean(status);

                    System.out.println("Booking Updated!");
                } else {
                    System.out.println("Invalid room index.");
                }
            }

            else if (choice == 4) {
                break;
            } else {
                System.out.println("Invalid option. Try again.");
            }
        }

        // Close the file after operations are done
        raf.close();
        sc.close();
    }
}