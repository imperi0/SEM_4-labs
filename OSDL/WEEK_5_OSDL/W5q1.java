package WEEK_5_OSDL;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;

public class W5q1 {
    public static void main(String[] args) {
        FileInputStream fis;
        FileOutputStream fos;
        int data;
        try {
            fis = new FileInputStream("C:\\Users\\mca\\OneDrive - Manipal Academy of Higher Education (1)\\Desktop\\SANJAI_240953252_19\\WEEK_5_OSDL\\sample.txt");
            fos = new FileOutputStream("C:\\Users\\mca\\OneDrive - Manipal Academy of Higher Education (1)\\Desktop\\SANJAI_240953252_19\\WEEK_5_OSDL\\sample2.txt");
            while((data=fis.read())!=-1){
                fos.write(data);
            }
            fis.close();
            fos.close();
        } catch(IOException e) {
            e.printStackTrace();
        }
    }
}
