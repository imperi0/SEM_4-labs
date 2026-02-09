package WEEK_5_OSDL;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;

public class example2 {
    public static void main(String[] args) {
        FileInputStream fis = null;
        FileOutputStream fos = null;
        int data;

        try {
            fis = new FileInputStream("C:\\Users\\mca\\Desktop\\image.webp");
            fos = new FileOutputStream("C:\\Users\\mca\\Desktop\\image_copy.webp");

            while ((data = fis.read()) != -1) {
                fos.write(data);
            }

            System.out.println("Image copied successfully!");

        } catch (IOException e) {
            System.out.println("An error occurred: " + e);
        } finally {
            try {
                if (fis != null) fis.close();
                if (fos != null) fos.close();
            } catch (IOException e) {
                System.out.println("Failed to close streams: " + e);
            }
        }
    }
}
