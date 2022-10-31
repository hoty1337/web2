package utils;

import data.UserAccount;

import javax.servlet.http.HttpSession;

public class AppUtils {
    public static void storeAuthorizedUser(HttpSession session, UserAccount authorizedUser) {
        session.setAttribute("authorizedUser", authorizedUser);
    }

    public static UserAccount getAuthorizedUser(HttpSession session) {
        return (UserAccount) session.getAttribute("authorizedUser");
    }
}
