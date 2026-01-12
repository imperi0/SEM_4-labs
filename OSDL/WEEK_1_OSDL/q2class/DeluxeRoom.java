package WEEK_1_OSDL.q2class;
import WEEK_1_OSDL.q2class.Room;

public class DeluxeRoom extends Room {
    public boolean wifiAvail;
    public boolean complBfast;

    public DeluxeRoom(int roomNumber, String roomType, double basePrice, boolean wifiAvail, boolean complBfast){
        super(roomNumber, roomType, basePrice);
        this.wifiAvail = wifiAvail;
        this.complBfast = complBfast;
    }
}
