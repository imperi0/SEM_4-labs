package WEEK_7_OSDL;

public class W7q2 {

    public static <T> void display(T data) {
        System.out.println(data);
    }

    public static void main(String[] args) {

        Integer roomNumber = 205;
        String roomType = "Suite";
        Double pricePerNight = 249.99;
        Boolean bookingStatus = true;

        System.out.print("Room Number: ");
        display(roomNumber);

        System.out.print("Room Type: ");
        display(roomType);

        System.out.print("Price Per Night: ");
        display(pricePerNight);

        System.out.print("Booking Status: ");
        display(bookingStatus);
    }
}