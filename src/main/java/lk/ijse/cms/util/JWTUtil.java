package lk.ijse.cms.util;

import com.auth0.jwt.JWT;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.exceptions.JWTVerificationException;
import com.auth0.jwt.interfaces.DecodedJWT;
import com.auth0.jwt.interfaces.JWTVerifier;
import jakarta.servlet.http.Cookie;

import java.util.Date;

public class JWTUtil {
    private static final String SECRET_KEY = "hehe$32524@";
    private static final long EXPIRATION_TIME = 1000 * 60 * 60 * 24;

    public static String generateToken(String userId, String username, String role) {
        return JWT.create()
                .withIssuer("auth0")
                .withSubject(userId)
                .withClaim("username", username)
                .withClaim("role", role)
                .withIssuedAt(new Date())
                .withExpiresAt(new Date(System.currentTimeMillis() + EXPIRATION_TIME))
                .sign(Algorithm.HMAC256(SECRET_KEY));
    }
    public static DecodedJWT decodeToken(String token) throws JWTVerificationException {
        try {
            Algorithm algorithm = Algorithm.HMAC256(SECRET_KEY);
            JWTVerifier verifier = JWT.require(algorithm)
                    .withIssuer("auth0")
                    .build();
            System.out.println("Decoding token: " + token);
            return verifier.verify(token);
        } catch (Exception e) {
            return null;
        }
    }
    public static DecodedJWT decodeToken(Cookie[] cookies) throws JWTVerificationException {
        for (Cookie cookie : cookies) {
            if ("jwt".equals(cookie.getName())) {
                String jwt = cookie.getValue();
                try {
                    Algorithm algorithm = Algorithm.HMAC256(SECRET_KEY);
                    JWTVerifier verifier = JWT.require(algorithm)
                            .withIssuer("auth0")
                            .build();
                    System.out.println("Decoding token: " + jwt);
                    return verifier.verify(jwt);
                } catch (Exception e) {
                    return null;
                }
            }
        }
        return null;
    }
}
