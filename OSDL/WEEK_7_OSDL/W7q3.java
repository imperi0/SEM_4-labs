package WEEK_7_OSDL;

import java.util.Scanner;

public class W7q3 {

    public static void main(String[] args) {

        Scanner sc = new Scanner(System.in);

        System.out.print("Enter room price: ");
        Double price = sc.nextDouble();

        System.out.print("Enter discount: ");
        Double discount = sc.nextDouble();

        RoomCharges<Double> room = new RoomCharges<>(price, discount);
        room.displayCharges();

        sc.close();
    }
}

class RoomCharges<T extends Number> {

    T roomPrice;
    T discount;

    public RoomCharges(T roomPrice, T discount) {
        this.roomPrice = roomPrice;
        this.discount = discount;
    }

    public double calculateTotalPrice() {
        return roomPrice.doubleValue();
    }

    public double calculateDiscountedPrice() {
        return roomPrice.doubleValue() - discount.doubleValue();
    }

    public void displayCharges() {
        System.out.println("Room Price       : " + roomPrice);
        System.out.println("Discount         : " + discount);
        System.out.println("Total Price      : " + calculateTotalPrice());
        System.out.println("Discounted Price : " + calculateDiscountedPrice());
    }
}

