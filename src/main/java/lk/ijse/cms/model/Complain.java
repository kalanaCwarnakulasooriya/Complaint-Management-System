package lk.ijse.cms.model;

public class Complain {
    private int id;
    private String title;
    private String description;
    private String status;
    private String remarks;
    private String created_at;
    private String user_id;
    private String catogory;

    public Complain() {}

    public Complain(int id, String title, String description, String status, String remarks, String created_at, String user_id) {
        this.id = id;
        this.title = title;
        this.description = description;
        this.status = status;
        this.remarks = remarks;
        this.created_at = created_at;
        this.user_id = user_id;
    }
    public Complain(int id, String title, String description, String status, String remarks, String created_at, String user_id, String catogory) {
        this.id = id;
        this.title = title;
        this.description = description;
        this.status = status;
        this.remarks = remarks;
        this.created_at = created_at;
        this.user_id = user_id;
        this.catogory = catogory;
    }
    public Complain(int id, String title, String description, String status, String created_at) {
        this.id = id;
        this.title = title;
        this.description = description;
        this.status = status;
        this.created_at = created_at;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }

    public String getCreated_at() {
        return created_at;
    }

    public void setCreated_at(String created_at) {
        this.created_at = created_at;
    }
    public String getUser_id() {
        return user_id;
    }
    public void setUser_id(String user_id) {
        this.user_id = user_id;
    }
}
