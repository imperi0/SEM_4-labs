import javafx.application.Application;
import javafx.beans.property.*;
import javafx.collections.*;
import javafx.geometry.Insets;
import javafx.scene.Scene;
import javafx.scene.control.*;
import javafx.scene.layout.*;
import javafx.stage.Stage;
import javafx.util.StringConverter;

public class HotelApp extends Application {

    private ObservableList<Room> roomList = FXCollections.observableArrayList();
    private TableView<Room> table = new TableView<>();

    private TextField roomNumberField = new TextField();
    private ComboBox<String> roomTypeBox = new ComboBox<>();
    private TextField priceField = new TextField();

    private TextField customerNameField = new TextField();
    private TextField contactField = new TextField();
    private ComboBox<Room> roomSelectBox = new ComboBox<>();

    private Label messageLabel = new Label();

    @Override
    public void start(Stage stage) {
        roomTypeBox.getItems().addAll("Single", "Double", "Deluxe");

        roomSelectBox.setConverter(new StringConverter<Room>() {
            @Override
            public String toString(Room room) {
                return room == null ? "" : "Room " + room.getRoomNumber();
            }
            @Override
            public Room fromString(String string) { return null; }
        });

        TableColumn<Room, Integer> colNumber = new TableColumn<>("Room No");
        colNumber.setCellValueFactory(data -> data.getValue().roomNumberProperty().asObject());

        TableColumn<Room, String> colType = new TableColumn<>("Type");
        colType.setCellValueFactory(data -> data.getValue().roomTypeProperty());

        TableColumn<Room, Double> colPrice = new TableColumn<>("Price ($)");
        colPrice.setCellValueFactory(data -> data.getValue().priceProperty().asObject());

        TableColumn<Room, String> colStatus = new TableColumn<>("Status");
        colStatus.setCellValueFactory(data -> data.getValue().statusProperty());

        TableColumn<Room, String> colCustomer = new TableColumn<>("Customer");
        colCustomer.setCellValueFactory(data -> data.getValue().customerNameProperty());

        table.getColumns().addAll(colNumber, colType, colPrice, colStatus, colCustomer);
        table.setItems(roomList);
        table.setColumnResizePolicy(TableView.CONSTRAINED_RESIZE_POLICY);

        GridPane roomForm = new GridPane();
        roomForm.setHgap(10); roomForm.setVgap(10);
        roomForm.addRow(0, new Label("Room No:"), roomNumberField, new Label("Type:"), roomTypeBox, new Label("Price:"), priceField);

        Button addRoomBtn = new Button("Add Room");
        Button showAllBtn = new Button("View All");
        Button showAvailableBtn = new Button("Available Only");
        HBox roomButtons = new HBox(10, addRoomBtn, showAllBtn, showAvailableBtn);

        GridPane customerForm = new GridPane();
        customerForm.setHgap(10); customerForm.setVgap(10);
        customerForm.addRow(0, new Label("Customer:"), customerNameField, new Label("Contact:"), contactField, new Label("Select Room:"), roomSelectBox);

        Button bookBtn = new Button("Book Room");
        Button checkoutBtn = new Button("Checkout Selected");
        HBox bookingButtons = new HBox(10, bookBtn, checkoutBtn);

        VBox root = new VBox(15,
                new Label("Room Management"), roomForm, roomButtons,
                new Separator(),
                new Label("Customer Booking"), customerForm, bookingButtons,
                table, messageLabel
        );
        root.setPadding(new Insets(20));


        addRoomBtn.setOnAction(e -> {
            try {
                int number = Integer.parseInt(roomNumberField.getText());
                String type = roomTypeBox.getValue();
                double price = Double.parseDouble(priceField.getText());

                if (type == null) throw new Exception();

                for (Room r : roomList) {
                    if (r.getRoomNumber() == number) {
                        showAlert("Room " + number + " already exists!");
                        return;
                    }
                }

                Room newRoom = new Room(number, type, price);
                roomList.add(newRoom);
                roomSelectBox.getItems().add(newRoom);
                messageLabel.setText("Room " + number + " added.");

                roomNumberField.clear();
                priceField.clear();
            } catch (Exception ex) {
                showAlert("Please enter valid room details!");
            }
        });

        bookBtn.setOnAction(e -> {
            Room selected = roomSelectBox.getValue();
            String name = customerNameField.getText();
            if (selected != null && !name.isEmpty()) {
                if (selected.getStatus().equals("Occupied")) {
                    showAlert("Room is already occupied!");
                } else {
                    selected.setCustomerName(name);
                    selected.setContact(contactField.getText());
                    selected.setStatus("Occupied");
                    table.refresh();
                    messageLabel.setText("Booking confirmed for " + name);
                    customerNameField.clear();
                    contactField.clear();
                }
            } else {
                showAlert("Ensure customer name and room are selected!");
            }
        });

        checkoutBtn.setOnAction(e -> {
            Room selected = table.getSelectionModel().getSelectedItem();
            if (selected != null && selected.getStatus().equals("Occupied")) {
                selected.setStatus("Available");
                selected.setCustomerName("");
                selected.setContact("");
                table.refresh();
                messageLabel.setText("Checked out Room " + selected.getRoomNumber());
            } else {
                showAlert("Select an occupied room from the table to checkout.");
            }
        });

        showAvailableBtn.setOnAction(e -> {
            table.setItems(roomList.filtered(r -> r.getStatus().equals("Available")));
        });

        showAllBtn.setOnAction(e -> table.setItems(roomList));

        stage.setTitle("Professional Hotel Management");
        stage.setScene(new Scene(root, 850, 600));
        stage.show();
    }

    private void showAlert(String msg) {
        Alert alert = new Alert(Alert.AlertType.WARNING);
        alert.setHeaderText(null);
        alert.setContentText(msg);
        alert.show();
    }

    public static void main(String[] args) { launch(args); }


    public static class Room {
        private final IntegerProperty roomNumber;
        private final StringProperty roomType;
        private final DoubleProperty price;
        private final StringProperty status;
        private final StringProperty customerName;
        private final StringProperty contact;

        public Room(int number, String type, double price) {
            this.roomNumber = new SimpleIntegerProperty(number);
            this.roomType = new SimpleStringProperty(type);
            this.price = new SimpleDoubleProperty(price);
            this.status = new SimpleStringProperty("Available");
            this.customerName = new SimpleStringProperty("");
            this.contact = new SimpleStringProperty("");
        }

        public int getRoomNumber() { return roomNumber.get(); }
        public IntegerProperty roomNumberProperty() { return roomNumber; }
        public StringProperty roomTypeProperty() { return roomType; }
        public DoubleProperty priceProperty() { return price; }
        public String getStatus() { return status.get(); }
        public StringProperty statusProperty() { return status; }
        public void setStatus(String s) { status.set(s); }
        public StringProperty customerNameProperty() { return customerName; }
        public void setCustomerName(String n) { customerName.set(n); }
        public void setContact(String c) { contact.set(c); }
    }
}
