<%@ page import="com.example.todolist.models.Task" %>
<%@ page import="com.example.todolist.constants.TaskStatus" %>
<%@ page import="java.time.LocalDate" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String today = LocalDate.now().toString();
    Task task = ((Task) request.getAttribute("task"));
%>
<html>
<head>
    <title>
        <%=request.getAttribute("action") == "edit" ? "Edit To Do": "Add To Do"%>
    </title>
</head>
<body>
<form action="<%="/TodoList" + (task != null ? ("/edit/?id=" + task.getId()) : "")%>" method="post">
    <h2>
        <%=request.getAttribute("action") == "edit" ? "Edit To Do" : "Add To Do"%>
    </h2>
    <h2>Title</h2>
    <input type="text" id="title" name="title" value="<%=task != null ? task.getTitle() : ""%>">
    <h2>Description</h2>
    <input type="text" id="description" name="description" value="<%=task != null ? task.getDescription() : ""%>">
    <h2>Status</h2>
    <select id="status" name="status" class="input">
        <% for (TaskStatus status : TaskStatus.values()) {
            boolean isSelected = (task != null && task.getStatus() == status);
        %>
        <option value="<%= status.name() %>" <%= isSelected ? "selected" : ""%>>
            <%= status.name() %>
        </option>
        <% } %>
    </select>
    <h2>Start Date</h2>
    <input id="start date" type="date" name="startDate"
           value="<%=task != null ? task.getTargetDate() : ""%>" min="<%= today %>">
    <h2>Target Date</h2>
    <input id="target date" type="date" name="targetDate"
           value="<%=task != null ? task.getTargetDate() : ""%>" min="<%= today %>">
    <input type="submit" value="Save">
</form>
</body>
</html>
