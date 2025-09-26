<%@ page import="java.util.List" %>
<%@ page import="com.example.todolist.models.Task" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Todo Application</title>
    <style><%@include file="styles/table.css"%></style>
</head>
    <body>
    <div id="mainTable">
        <table>
            <thead>
            <tr>
                <th>Title</th>
                <th>Description</th>
                <th>Status</th>
                <th>Start Date</th>
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
            <tr>
                <td><%= t.getTitle() %></td>
                <td><%= t.getDescription() %></td>
                <td><%= t.getStatus() %></td>
                <td><%= t.getStartDate()%></td>
                <td><%= t.getTargetDate() %></td>
                <td>
                    <form action="/TodoList/edit/?id=<%=t.getId()%>" method="get">
                        <input type="hidden" name="action" value="edit" />
                        <input type="hidden" name="id" value="<%=t.getId()%>" />
                        <input class="action-btn" type="submit" value="Edit"/>
                    </form>
                    <form id="deleteForm" action="/TodoList/delete/?id=<%=t.getId()%>" method="post">
                        <button type="button" onclick="showModal()">Delete</button>
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
    </div>
    <div id="confirmModal" class="modal" style="display: none; position: fixed; z-index: 1000; left: 0; top: 0; width: 100%; height: 100%; overflow: auto; background-color: white;">
        <div class="modal-content" style="margin: 15% auto; padding: 20px; border: 1px solid black; width: 80%; max-width: 500px; border-radius: 8px">
            <span class="close" onclick="closeModal()">&times;</span>
            <h2>Confirm Action</h2>
            <p>Are you sure you want to proceed with this action?</p>
            <button onclick="confirmAction()">Accept</button>
            <button onclick="closeModal()">Cancel</button>
        </div>
    </div>
    <script>
        var modal = document.getElementById('confirmModal');

        function showModal() {
            modal.style.display = "block";
        }

        function closeModal() {
            modal.style.display = "none";
        }

        function confirmAction() {
            var form = document.getElementById("deleteForm");
            form.submit();
        }
    </script>
    </body>
</html>