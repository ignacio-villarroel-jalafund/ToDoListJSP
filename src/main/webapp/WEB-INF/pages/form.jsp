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
    <style><%@include file="styles/form.css"%></style>
</head>
<body style="margin: 0; padding: 0; display: flex; flex-direction: column; min-height: 100vh;">
<jsp:include page="common/header.jsp" />
<div>

</div>
<form id="principalForm" action="<%="/TodoList" + (task != null ? ("/edit/?id=" + task.getId()) : "")%>" method="post">
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
           value="<%=task != null ? task.getStartDate() : ""%>" min="<%= today %>">
    <h2>Target Date</h2>
    <input id="target date" type="date" name="targetDate"
           value="<%=task != null ? task.getTargetDate() : ""%>" min="<%= today %>">
    <button type="button" onclick="showModal()">Save</button>
</form>
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
        var form = document.getElementById("principalForm");
        form.submit();
    }
</script>
<jsp:include page="common/footer.jsp" />
</body>
</html>
