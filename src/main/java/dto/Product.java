package dto;

public class Product {
    private String productId;
    private String name;
    private int unitPrice;
    private String manufacturer;
    private String category;
    private long unitsInStock;
    private String productImage;
    private int quantity;

    // 생성자, getter, setter 등 필요한 메서드를 추가할 수 있습니다.

    // 예시로 생성자와 getter, setter를 추가하였습니다.
    public Product() {
    }

    public Product(String productId, String name, int unitPrice, String manufacturer, String category, long unitsInStock, String productImage) {
        this.productId = productId;
        this.name = name;
        this.unitPrice = unitPrice;
        this.manufacturer = manufacturer;
        this.category = category;
        this.unitsInStock = unitsInStock;
        this.productImage = productImage;
    }
    
    public String getPname() {
        return getName();
    }
    
    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getProductId() {
        return productId;
    }

    public void setProductId(String productId) {
        this.productId = productId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getUnitPrice() {
        return unitPrice;
    }

    public void setUnitPrice(int unitPrice) {
        this.unitPrice = unitPrice;
    }

    public String getManufacturer() {
        return manufacturer;
    }

    public void setManufacturer(String manufacturer) {
        this.manufacturer = manufacturer;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public long getUnitsInStock() {
        return unitsInStock;
    }

    public void setUnitsInStock(long unitsInStock) {
        this.unitsInStock = unitsInStock;
    }

    public String getProductImage() {
        return productImage;
    }

    public void setProductImage(String productImage) {
        this.productImage = productImage;
    }
}

