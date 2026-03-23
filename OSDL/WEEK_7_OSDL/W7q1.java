package WEEK_7_OSDL;


public class W7q1 {

    public static void main(String[] args) {

        Room<Integer, String> room1 = new Room<>(101, "Deluxe");
        Room<String, Double> room2 = new Room<>("A-202", 199.99);
        Room<Integer, Double> room3 = new Room<>(303, 149.50);

        room1.displayRoomDetails();
        room2.displayRoomDetails();
        room3.displayRoomDetails();
    }
}

class Room<T, U> {

    private T roomID;
    private U roomAtr;

    public Room(T roomID, U roomAtr) {
        this.roomID = roomID;
        this.roomAtr = roomAtr;
    }

    public T roomID() {
        return roomID;
    }

    public U roomAtr() {
        return roomAtr;
    }

    public void displayRoomDetails() {
        System.out.println("Room Identifier: " + roomID);
        System.out.println("Room Attribute : " + roomAtr);
    }
}
