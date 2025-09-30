<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div id="popUp" style="position: fixed; top: 20px; right: 20px;"></div>

<script>
    function showPopUp(message, type = "success") {
        const popUp = document.createElement("div");
        popUp.innerText = message;
        popUp.style.padding = "10px 20px";
        popUp.style.marginTop = "10px";
        popUp.style.borderRadius = "5px";
        popUp.style.color = "#fff";
        popUp.style.boxShadow = "0 2px 6px rgba(0,0,0,0.2)";
        popUp.style.opacity = "0";
        popUp.style.transition = "opacity 0.5";

        if (type === "succes") {
            popUp.style.background = "#28a745"
        } else if (type === error) {
            popUp.style.background = "#dc3545";
        } else {
            popUp.style.background = "#6c757d";
        }

        document.getElementById("popUp").appendChild(popUp);

        setTimeout(() => { popUp.style.opacity = "1";}, 100);
        setTimeout(() => { popUp.style.opacity = "0"; setTimeout(() => popUp.remove())}, 3000)

    }
</script>
