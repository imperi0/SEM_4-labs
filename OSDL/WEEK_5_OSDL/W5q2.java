package WEEK_5_OSDL;

import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;

public class W5q2 {
    public static void main(String[] args) {
        FileReader fr = null;
        FileWriter fw = null;
        int data;

        try {
            fr = new FileReader("C:\\Users\\mca\\OneDrive - Manipal Academy of Higher Education (1)\\Desktop\\SANJAI_240953252_19\\WEEK_5_OSDL\\sample.txt");
            fw = new FileWriter("C:\\Users\\mca\\OneDrive - Manipal Academy of Higher Education (1)\\Desktop\\SANJAI_240953252_19\\WEEK_5_OSDL\\sample3.txt");

            while ((data = fr.read()) != -1) {
                fw.write(data);
            }

            System.out.println("File copied successfully!");

        } catch (IOException e) {
            System.out.println("An error occurred: " + e);
        } finally {
            try {
                if (fr != null) fr.close();
                if (fw != null) fw.close();
            } catch (IOException e) {
                System.out.println("Failed to close streams: " + e);
            }
        }
    }
}
