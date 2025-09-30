<%@ page import="com.example.todolist.models.Task" %>
<%@ page import="com.example.todolist.constants.TaskStatus" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.util.Objects" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String today = LocalDate.now().toString();
    Task task = ((Task) request.getAttribute("task"));
    Object action = request.getAttribute("action");
    String confirmAction = Objects.equals(action, "edit") ? "Edit" : "Add";
%>
<html>
<head>
    <title>
        <%=Objects.equals(action, "edit") ? "Edit To Do": "Add To Do"%>
    </title>
    <style><%@include file="styles/form.css"%></style>
</head>
<body style="margin: 0; padding: 0; display: flex; flex-direction: column; min-height: 100vh; flex:1">
<jsp:include page="common/header.jsp" />
<form id="principalForm" action="<%="/TodoList" + (task != null ? ("/edit/?id=" + task.getId()) : "")%>"
      method="post">
    <h2>
        <%=request.getAttribute("action") == "edit" ? "Edit To Do" : "Add To Do"%>
    </h2>
    <h2>Title</h2>
    <input type="text" id="title" name="title" value="<%=task != null ? task.getTitle() : ""%>">
    <h2>Description</h2>
    <input type="text" id="description" name="description"
           value="<%=task != null ? task.getDescription() : ""%>">
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
           value="<%=task != null ? task.getStartDate() : ""%>" min="<%= today %>">
    <h2>Target Date</h2>
    <input id="target date" type="date" name="targetDate"
           value="<%=task != null ? task.getTargetDate() : ""%>" min="<%= today %>">
    <button type="button" onclick="openConfirm('principalForm', '<%= confirmAction %> task',
            'Are you sure you want to <%= confirmAction.toLowerCase() %> this task?')">Save</button>
</form>
<jsp:include page="confirmDialog.jsp" />
<jsp:include page="common/footer.jsp" />

<script>
    showPopUp("Task <%= confirmAction.toLowerCase() %> successfully", "success");
</script>
</body>
</html>
