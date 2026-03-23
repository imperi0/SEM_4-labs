package WEEK_7_OSDL;

public class W7q5 {

    public static void main(String[] args) {

        Pair<Integer, String> booking1 = new Pair<>(101, "Rahul");
        Pair<Integer, String> booking2 = new Pair<>(102, "Anita");

        booking1.display();
        booking2.display();
    }
}

class Pair<T, U> {

    private T roomNumber;
    private U guestName;

    public Pair(T roomNumber, U guestName) {
        this.roomNumber = roomNumber;
        this.guestName = guestName;
    }

    public void display() {
        System.out.println("Room Number: " + roomNumber + " | Guest Name: " + guestName);
    }
}