package WEEK_1_OSDL.q3class;

public class Room {

    public int roomNumber;
    public double baseTariff;

    public Room(int roomNumber, double baseTariff){
        this.roomNumber = roomNumber;
        this.baseTariff = baseTariff;
    }

    public double calculateTariff(){
        return baseTariff;
    }

}
