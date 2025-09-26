<html>
  <body style="margin: 0; padding: 0; display: flex; flex-direction: column; min-height: 100vh;">
    <jsp:include page="header.jsp" />
    <div style="flex: 1; margin-top: 10px; margin-bottom: 10px;">
      <div style="border-bottom: 2px solid black; justify-content: center; text-align: center;">
          <h1>List of Todos</h1>
      </div>
      <button style="width: 100px; background-color: oklch(72.3% 0.219 149.579);">Add +</button>
      <jsp:include page="table.jsp" />
    </div>
    <jsp:include page="footer.jsp" />
  </body>
</html>
