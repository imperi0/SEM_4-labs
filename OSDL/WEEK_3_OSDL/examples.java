package WEEK_3_OSDL;

public class examples extends Thread {
    private String roomName;

    // Constructor
    examples(String roomName) {
        this.roomName = roomName;
    }

    // Overriding run() method
    @Override
    public void run() {
        for (int i = 1; i <= 5; i++) {
            System.out.println(roomName + " - Cleaning step " + i);
            try {
                Thread.sleep(2500); // Pause thread execution
            } catch (InterruptedException e) {
                System.out.println("Thread interrupted");
            }
        }
    }
    public static void main(String[] args) {

        // Creating thread objects
        Thread t1 = new examples("Room 101");
        Thread t2 = new examples("Room 102");

        // Starting threads
        t1.start();
        t2.start();

        //run() → what the thread should do
        //start() → how the thread is started

        //Runnable provides the run() logic (the task)
        //Thread provides the actual thread of execution

    }


}
