package WEEK_5_OSDL;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;

public class example {
    public static void main(String[] args) {
        try {
            FileOutputStream fos = new FileOutputStream(
                "C:\\Users\\mca\\OneDrive - Manipal Academy of Higher Education (1)\\Desktop\\SANJAI_240953252_19\\sample.txt",
                true
            );

            String message = "\nThis is the third line";
            byte[] data=message.getBytes();

            fos.write(data);

            fos.close();

        } catch (IOException e) {
            System.out.println(e);
        }
    }
}
