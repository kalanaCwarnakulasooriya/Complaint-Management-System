package lk.ijse.Model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor

public class User {
    private String userId;
    private String name;
    private String address;
    private String mobile;
    private String email;
    private String username;
    private String password;
    private String department;
    private String jobRole;
}
