package WEEK_3_OSDL;

public class W3q2 {
    public static void main(String[] args) {    
        
        Thread order101Validation = new OrderTask(101, "Validation");
        Thread order101Payment = new OrderTask(101, "Payment");
        Thread order101Shipment = new OrderTask(101, "Shipment");

        Thread order102Validation = new OrderTask(102, "Validation");
        Thread order102Payment = new OrderTask(102, "Payment");
        Thread order102Shipment = new OrderTask(102, "Shipment");

        order101Validation.start();
        order101Payment.start();
        order101Shipment.start();
        order102Validation.start();
        order102Payment.start();
        order102Shipment.start();

        try {
            order101Validation.join();
            order101Payment.join();
            order101Shipment.join();
            order102Validation.join();
            order102Payment.join();
            order102Shipment.join();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }

        System.out.println("All orders have been processed!");
    }
}

class OrderTask extends Thread {
    private int orderId;
    private String taskType;

    public OrderTask(int orderId, String taskType) {
        this.orderId = orderId;
        this.taskType = taskType;
    }

    @Override
    public void run() {
        System.out.println(taskType + " started for Order " + orderId + "...");
        try {
            switch (taskType) {
                case "Validation":
                    Thread.sleep(2000);
                    break;
                case "Payment":
                    Thread.sleep(3000);
                    break;
                case "Shipment":
                    Thread.sleep(4000);
                    break;
            }
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        System.out.println(taskType + " completed for Order " + orderId);
    }
}

