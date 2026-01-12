package WEEK_1_OSDL.q2class;

public class Room {
    
    public int roomNumber ;
    public String roomType ;
    public double basePrice ;

    public Room(int roomNumber, String roomType){
        this.roomNumber = roomNumber;
        this.roomType = roomType;
    }

    public Room(int roomNumber, String roomType, double basePrice){
        this.roomNumber = roomNumber;
        this.roomType = roomType;
        this.basePrice = basePrice;
    }

}