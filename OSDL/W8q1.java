import java.util.*;

class Room {
    int no;
    String type;
    double price;
    boolean available = true;

    Room(int no, String type, double price) {
        this.no = no;
        this.type = type;
        this.price = price;
    }
}

class Customer {
    int id, roomNo;
    String name;

    Customer(int id, String name) {
        this.id = id;
        this.name = name;
        this.roomNo = -1;
    }
}

public class W8q1 {
    static List<Room> rooms = new ArrayList<>();
    static List<Customer> customers = new ArrayList<>();
    static HashMap<Integer, Customer> bookings = new HashMap<>();
    static Scanner sc = new Scanner(System.in);

    static void addRoom() {
        System.out.print("Room No, Type, Price: ");
        rooms.add(new Room(sc.nextInt(), sc.next(), sc.nextDouble()));
    }

    static void showRooms() {
        Collections.sort(rooms, Comparator.comparingDouble(r -> r.price));
        for (Room r : rooms)
            if (r.available)
                System.out.println(r.no + " " + r.type + " " + r.price);
    }

    static void addCustomer() {
        System.out.print("ID Name: ");
        customers.add(new Customer(sc.nextInt(), sc.next()));
    }

    static Customer findCustomer(int id) {
        for (Customer c : customers)
            if (c.id == id) return c;
        return null;
    }

    static Room findRoom(int no) {
        for (Room r : rooms)
            if (r.no == no) return r;
        return null;
    }

    static void bookRoom() {
        System.out.print("Customer ID & Room No: ");
        Customer c = findCustomer(sc.nextInt());
        Room r = findRoom(sc.nextInt());

        if (c == null || r == null || !r.available) {
            System.out.println("Booking failed");
            return;
        }

        r.available = false;
        c.roomNo = r.no;
        bookings.put(r.no, c);
        System.out.println("Booked!");
    }

    static void checkout() {
        System.out.print("Room No: ");
        int no = sc.nextInt();

        if (!bookings.containsKey(no)) {
            System.out.println("No booking");
            return;
        }

        Room r = findRoom(no);
        r.available = true;
        bookings.get(no).roomNo = -1;
        bookings.remove(no);

        System.out.println("Checked out!");
    }

    static void showCustomers() {
        Iterator<Customer> it = customers.iterator();
        while (it.hasNext()) {
            Customer c = it.next();
            System.out.println(c.id + " " + c.name + " Room: " + c.roomNo);
        }
    }

    public static void main(String[] args) {
        while (true) {
            System.out.println("\n1.Add Room 2.Show Rooms 3.Add Customer 4.Book 5.Checkout 6.Customers 7.Exit");
            switch (sc.nextInt()) {
                case 1: addRoom(); break;
                case 2: showRooms(); break;
                case 3: addCustomer(); break;
                case 4: bookRoom(); break;
                case 5: checkout(); break;
                case 6: showCustomers(); break;
                case 7: return;
                default: System.out.println("Invalid");
            }
        }
    }
}