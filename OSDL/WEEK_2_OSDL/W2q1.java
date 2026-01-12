package WEEK_2_OSDL;

public class W2q1 {
    public static void main(String[] args) {

        double roomTariff = 1000.0;
        int noOfDays = 5;
        double serviveCharges = 500.0;

        //AutoBoxing
        Double tariffObj = roomTariff;
        Integer daysObj = noOfDays;
        Double serviceChargeObj = serviveCharges;

        //Unboxing
        double totalCharge = tariffObj * daysObj;
        double totalBill = totalCharge + serviceChargeObj;

        System.out.println("Room tariff : " + tariffObj);
        System.out.println("Number of days : " + daysObj);
        System.out.println("Sevive charge : " + serviceChargeObj);

        System.out.println("Total bill : " + totalBill);

        return ;
    }
}

