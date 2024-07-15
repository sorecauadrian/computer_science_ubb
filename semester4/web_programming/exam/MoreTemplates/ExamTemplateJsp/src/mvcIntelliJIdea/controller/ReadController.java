package mvcIntelliJIdea.controller;

import mvcIntelliJIdea.dbHelper.ReadQuery;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class ReadController extends HttpServlet {
    public ReadController() { super(); }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        ReadQuery rq = new ReadQuery();

        //Get the HTML table
        rq.doRead();
        String table = rq.getHTMLTable();

        //Pass execution control to success.jsp along with the table
        req.setAttribute("table", table);
        String url = "/read.jsp";

        //Communicate with other files
        RequestDispatcher dispatcher = req.getRequestDispatcher(url);
        dispatcher.forward(req, resp);
    }
}
