package WEEK_1_OSDL.q3class;

public class StandardRoom extends Room {
    
    public double acCharges;

    public StandardRoom(int roomNumber, double baseTariff, double acCharges){
        super(roomNumber, baseTariff);
        this.acCharges = acCharges;
    }

    @Override
    public double calculateTariff(){
        return this.baseTariff+this.acCharges;
    }

}
