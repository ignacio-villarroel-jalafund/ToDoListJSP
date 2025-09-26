<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String action = request.getParameter("action");
    String message = request.getParameter("message");
    String url = request.getParameter("url");
%>
<div style="border: 1px solid gray; padding: 10px; background: white; margin: 10px 0;">
    <p><b><%= message!= null ? message: "¿Estás seguro que desea continuar con la acción?" %></b></p>
    <form action="<%= url %>" method="post">
        <input type="hidden" name="action" value="<%= action %>">
        <input type="submit" value="Confirm">
    </form>
    <button type="button" onclick="history.back()">Cancel</button>
</div>
