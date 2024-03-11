package dto;

public class Delivery {
    private String d_id;
    private String u_id; // 추가된 필드
    private String d_name;
    private String d_phone;
    private String d_address;

    // 생성자
    public Delivery() {
    }

    public Delivery(String d_id, String u_id, String d_name, String d_phone, String d_address) {
        this.d_id = d_id;
        this.u_id = u_id;
        this.d_name = d_name;
        this.d_phone = d_phone;
        this.d_address = d_address;
    }

    // Getter 및 Setter 메서드
    public String getD_id() {
        return d_id;
    }

    public void setD_id(String d_id) {
        this.d_id = d_id;
    }

    public String getU_id() {
        return u_id;
    }

    public void setU_id(String u_id) {
        this.u_id = u_id;
    }

    public String getD_name() {
        return d_name;
    }

    public void setD_name(String d_name) {
        this.d_name = d_name;
    }

    public String getD_phone() {
        return d_phone;
    }

    public void setD_phone(String d_phone) {
        this.d_phone = d_phone;
    }

    public String getD_address() {
        return d_address;
    }

    public void setD_address(String d_address) {
        this.d_address = d_address;
    }
}
