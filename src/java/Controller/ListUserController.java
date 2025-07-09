package Controller;

import DAO.UserDAO;
import Model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;

public class ListUserController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        UserDAO dao = new UserDAO();
        ArrayList<User> users = dao.getAllUsers();

        request.setAttribute("userList", users);
        request.getRequestDispatcher("ListUser.jsp").forward(request, response);
    }

}