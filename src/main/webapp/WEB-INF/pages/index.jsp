<html>
<body style="margin: 0; padding: 0; display: flex; flex-direction: column; min-height: 100vh;">
<%
    String popUpMessage = (String) session.getAttribute("popUpMessage");
    String popUpType = (String) session.getAttribute("popUpType");
%>
<jsp:include page="common/header.jsp" />
<div style="flex: 1; margin-top: 10px; margin-bottom: 10px;">
    <div style="border-bottom: 2px solid black; justify-content: center; text-align: center;">
        <h1>List of To Dos</h1>
    </div>
    <form action="/TodoList/new" method="post">
        <input type="submit" value="Add +" class="btn" style="background-color: green; color: white; font-size: 20px; padding: 0 50px;"/>
    </form>
    <jsp:include page="table.jsp" />
</div>
<jsp:include page="popUp.jsp"/>
<jsp:include page="common/footer.jsp" />
<script>
    if (<%= popUpMessage %> != null) {
        showPopUp("<%= popUpMessage %>", "<%= popUpType %>");
    }
</script>
<%
    session.removeAttribute("popUpMessage");
    session.removeAttribute("popUpType");
%>
</body>
</html>
