package WEEK_2_OSDL;

import java.util.Scanner;

public class W2q2 {
    public static void main(String[] args) {
        
        Scanner sc = new Scanner(System.in);
        
        int choice;
        int noOfDays;
        System.out.println("Available rooms : ");
        System.out.println("1 . Standard Room ");
        System.out.println("2 . Deluxe Room ");
        System.out.println("3 . Suite ");
        System.out.print("Enter choice :" );
        choice = sc.nextInt();

        System.out.print("Enter number of days : ");
        noOfDays = sc.nextInt();

        RoomType room = null;

        switch(choice){
            case 1 : 
                room = RoomType.STANDARD;
                break;
            case 2 : 
                room = RoomType.DELUXE;
                break;
            case 3 : 
                room = RoomType.SUITE;
                break;
            default :
                System.out.println("Invalid choice");
        }

        //room = RoomType.STANDARD;

        System.out.println("Room Type : " + room);
        System.out.println("Tariff : " + room.returnBaseTariff());
        System.out.println("No of days : " + noOfDays);
        System.out.println("Total cost : " + room.calculateCost(noOfDays));
        return ;


    }
}

enum RoomType {
    STANDARD(1000.0),
    DELUXE(2500.0),
    SUITE(3000);

    double baseTariff;

    RoomType(double basePrice){
        this.baseTariff = basePrice;
    }

    public double returnBaseTariff(){
        return baseTariff;
    }

    public double calculateCost(int noOfDays){
        return baseTariff * noOfDays;
    }
}