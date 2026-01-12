package WEEK_1_OSDL;

class Book {

    private int ID;
    private String title;
    private String authorName;
    private int price;
    private boolean avail;
    
    public void setID(int ID){
        this.ID = ID;
    }

    public void setTitle(String title){
        this.title = title;
    }

    public void setAuthorName(String authorName){
        this.authorName = authorName;
    }

    public void setPrice(int price){
        if(price>0){
            this.price = price;
        }
        else{
            System.err.println("Enter positive Price for setter");
            this.price = 0;
        }
    }

    public void setAvail(boolean avail){
        this.avail = avail;
    }
    
    public int getID(){
        return this.ID;
    }

    public String getTitle(){
        return this.title;
    }

    public String getAuthorName(){
        return this.authorName;
    }

    public int getPrice(){
        return this.price;
    }

    public boolean getAvail(){
        return this.avail;
    }
}

public class W1q1 {
    
    public static void main(String[] args) {
        
        Book book = new Book();
        book.setID(1);
        book.setAuthorName("Oda");
        book.setTitle("One Piece");
        book.setPrice(1000);
        book.setAvail(true);

        String avail=book.getAvail()?" Available":"NA";

        System.out.println("ID : " + book.getID());
        System.out.println("Title : " + book.getTitle());
        System.out.println("Author : " + book.getAuthorName());
        System.out.println("Price : " + book.getPrice());
        System.out.println("Availblity : " + avail);

    }

}
