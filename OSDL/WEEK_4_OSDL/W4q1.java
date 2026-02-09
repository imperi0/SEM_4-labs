public class W4q1 {
    public static void main(String[] args) {
        Hotel hotel = new Hotel();

        new Room("Customer-1", hotel).start();
        new Room("Customer-2", hotel).start();
        new Room("Customer-3", hotel).start();
        new Room("Customer-4", hotel).start();
        new Room("Customer-5", hotel).start();
    }
}


class Hotel {

    private int roomsAvail = 3;

    synchronized void bookRoom() {
        while (roomsAvail == 0) {
            try {
                System.out.println(Thread.currentThread().getName() + " waiting for room...");
                wait();
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
        roomsAvail--;
        System.out.println(Thread.currentThread().getName() + " got a room. Rooms left: " + roomsAvail);
    }

    synchronized void releaseRoom() {
        roomsAvail++;
        System.out.println(Thread.currentThread().getName() + " released a room. Rooms left: " + roomsAvail);
        notifyAll();
    }
}

class Room extends Thread {

    private Hotel hotel;

    public Room(String name, Hotel hotel) {
        super(name);
        this.hotel = hotel;
    }

    public void run() {
        hotel.bookRoom();
        try {
            Thread.sleep(3000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        hotel.releaseRoom();
    }
}