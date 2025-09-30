<%@ page import="java.util.List" %>
<%@ page import="com.example.todolist.models.Task" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@page import="org.apache.commons.text.StringEscapeUtils" %>
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
                <td><%= StringEscapeUtils.escapeHtml4(t.getTitle()) %></td>
                <td><%= StringEscapeUtils.escapeHtml4(t.getDescription()) %></td>
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
                        <button type="button"
                                onclick="openConfirm('deleteForm', 'Delete task', 'Are you sure you want to delete this task?')">
                            Delete
                        </button>
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
                    class="pagination-item <%=request.getParameter("page") != null &&
                      Integer.parseInt(request.getParameter("page")) == i ? "pagination-selected" : ""%>"
                    href="/TodoList?page=<%=i%>"><%=i%>
            </a>
            <%
                    }
                }
            %>
        </nav>
    </div>
    <jsp:include page="confirmDialog.jsp"/>
    </body>
</html>