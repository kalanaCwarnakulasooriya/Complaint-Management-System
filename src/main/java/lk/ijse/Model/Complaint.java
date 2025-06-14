package lk.ijse.Model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class Complaint {
    private String complaintId;
    private String userId;
    private String title;
    private String description;
    private String status;
    private String remarks;
    private String createdAt;
}