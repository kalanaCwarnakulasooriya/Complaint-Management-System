package lk.ijse.cms.util;

import at.favre.lib.crypto.bcrypt.BCrypt;

public class UserEncryption {
    public static String encrypt(String password) throws Exception {
        return BCrypt.withDefaults().hashToString(12, password.toCharArray());
    }

    public static Boolean decrypt(String userInput, String fromDB) throws Exception {
        try {
            BCrypt.Result result = BCrypt.verifyer().verify(userInput.toCharArray(), fromDB);
            return result.verified;
        } catch (Exception e) {
            return false;
        }
    }
}
