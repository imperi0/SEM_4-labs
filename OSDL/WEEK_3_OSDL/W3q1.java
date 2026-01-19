package WEEK_3_OSDL;

public class W3q1 {
    public static void main(String[] args) {
        Thread roomCleaningThread = new RoomCleaningThread();
        FoodDeliveryThread foodDeliveryThread = new FoodDeliveryThread();
        MaintenanceThread maintenanceThread = new MaintenanceThread();
        roomCleaningThread.start();
        foodDeliveryThread.start();
        maintenanceThread.start();
        try {
            roomCleaningThread.join();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        try {
            foodDeliveryThread.join();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        try {
            maintenanceThread.join();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        System.out.println("All task completed");
    }
}

class RoomCleaningThread extends Thread{
    @Override
    public void run(){
        System.out.println("Room cleaning started....");
        try {
            Thread.sleep(2000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        System.out.println("Room has been cleaned....");
    }
}


class FoodDeliveryThread extends Thread{
    @Override
    public void run(){
        System.out.println("Food is being delivered....");
        try {
            Thread.sleep(3000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        System.out.println("Food has been delivered....");
    }
}


class MaintenanceThread extends Thread{
    @Override
    public void run(){
        System.out.println("Room maintenance has been called....");
        try {
            Thread.sleep(4000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        System.out.println("Room maintenance done....");
    }
}