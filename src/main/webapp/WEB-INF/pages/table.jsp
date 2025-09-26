<%@ page import="java.util.List" %>
<%@ page import="com.example.todolist.models.Task" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Todo Application</title>
</head>
    <body>
        <table style="justify-content: center; display: flex; flex-direction: column;">
            <thead>
                <tr style="display: flex; gap: 100px; justify-content: center; font-size: 30px;">
                    <th>Title</th>
                    <th>Description</th>
                    <th>Status</th>
                    <th>Target Date</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
            <%
                List<Task> tasks = (List<Task>) request.getAttribute("tasks");
                if (tasks != null) {
                    for (Task t : tasks) {
            %>
            <tr style="display: flex; justify-content: center; align-items: center; gap: 100px;">
                <td><%= t.getTitle() %></td>
                <td><%= t.getDescription() %></td>
                <td><%= t.getStatus() %></td>
                <td><%= t.getTargetDate() %></td>
                <td style="display: flex; flex-direction: column;">
                    <form action="/TodoList/edit/?id=<%=t.getId()%>" method="get">
                        <input type="hidden" name="action" value="edit" />
                        <input type="hidden" name="id" value="<%=t.getId()%>" />
                        <input class="action-btn" type="submit" value="Edit"/>
                    </form>
                    <form action="/TodoList/delete/?id=<%=t.getId()%>" method="post">
                        <input class="action-btn" type="submit" value="Delete"/>
                    </form>
                </td>
            </tr>
            <%
                    }
                }
            %>
            </tbody>
        </table>
    <nav class="pagination" style="display: flex; justify-content: center; align-items: center;">
        <%
            int totalPages = (Integer) request.getAttribute("totalPageNumber");
            if (totalPages > 1) {
                for (int i = 1; i < totalPages + 1; i++) {
        %>
        <a
                class="pagination-item <%=request.getParameter("page") != null &&  Integer.parseInt(request.getParameter("page")) == i ? "pagination-selected" : ""%>"
                href="/TodoList?page=<%=i%>"><%=i%>
        </a>
        <%
                }
            }
        %>
    </nav>
    </body>
</html>