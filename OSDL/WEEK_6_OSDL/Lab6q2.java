import java.io.*;
import java.util.*;

class Room implements Serializable {

    int roomNo;
    String type;
    double price;
    boolean booked;
    String guestName;

    Room(int r, String t, double p, boolean b, String g) {
        roomNo = r;
        type = t;
        price = p;
        booked = b;
        guestName = g;
    }

    public String toString() {
        return roomNo + " | " + type + " | " + price +
               " | Booked: " + booked +
               " | Guest: " + guestName;
    }
}

public class Lab6q2 {

    static String FILE = "rooms.ser";

    // Save list
    static void save(List<Room> list) throws Exception {
        ObjectOutputStream oos = new ObjectOutputStream(new FileOutputStream(FILE));
        oos.writeObject(list);
        oos.close();
    }

    // Load list
    static List<Room> load() throws Exception {
        File f = new File(FILE);
        if (!f.exists()) return new ArrayList<>();

        ObjectInputStream ois = new ObjectInputStream(new FileInputStream(FILE));
        List<Room> list = (List<Room>) ois.readObject();
        ois.close();
        return list;
    }

    public static void main(String[] args) throws Exception {

        Scanner sc = new Scanner(System.in);

        while (true) {

            System.out.println("\n1.Add Room");
            System.out.println("2.Display All");
            System.out.println("3.Search Room");
            System.out.println("4.Update Booking");
            System.out.println("5.Exit");
            System.out.println("Enter your choice:");

            int ch = sc.nextInt();

            List<Room> rooms = load();

            if (ch == 1) {

                System.out.print("Room No: ");
                int r = sc.nextInt();
                sc.nextLine();

                System.out.print("Type: ");
                String t = sc.nextLine();

                System.out.print("Price: ");
                double p = sc.nextDouble();

                System.out.print("Booked (true/false): ");
                boolean b = sc.nextBoolean();
                sc.nextLine();

                System.out.print("Guest Name: ");
                String g = sc.nextLine();

                rooms.add(new Room(r, t, p, b, g));
                save(rooms);

                System.out.println("Room Saved!");
            }

            else if (ch == 2) {
                for (Room rm : rooms)
                    System.out.println(rm);
            }

            else if (ch == 3) {
                System.out.print("Enter Room No: ");
                int r = sc.nextInt();

                for (Room rm : rooms)
                    if (rm.roomNo == r)
                        System.out.println(rm);
            }

            else if (ch == 4) {
                System.out.print("Enter Room No: ");
                int r = sc.nextInt();

                for (Room rm : rooms)
                    if (rm.roomNo == r) {
                        rm.booked = !rm.booked;
                        System.out.println("Booking toggled!");
                    }

                save(rooms);
            }

            else break;
        }
    }
}