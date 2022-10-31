package data;

import java.util.HashMap;
import java.util.Map;

public class Data {
    private static final Map<String, UserAccount> mapUsers = new HashMap<String, UserAccount>();

    static {
        initUsers();
    }

    private static void initUsers() {
        UserAccount newUser = new UserAccount("user", "123");
        mapUsers.put(newUser.getUsername(), newUser);
    }

    public static UserAccount findUser(String username, String password) {
        UserAccount user = mapUsers.get(username);
        if(user != null && user.getPassword().equals(password)) {
            return user;
        }
        return null;
    }
}
