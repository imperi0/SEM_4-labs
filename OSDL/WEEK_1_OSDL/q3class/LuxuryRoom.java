package WEEK_1_OSDL.q3class;

public class LuxuryRoom extends Room {
    
    public double acCharges;
    public double extraAmenities;
    public double premiumServices;

    public LuxuryRoom(int roomNumber, double baseTariff, double acCharges, double extraAmenities, double premiumServices){
        super(roomNumber, baseTariff);
        this.acCharges = acCharges;
        this.extraAmenities = extraAmenities;
        this.premiumServices = premiumServices;
    }

    @Override
    public double calculateTariff(){
        return this.baseTariff+this.acCharges+this.extraAmenities+this.premiumServices;
    }

}