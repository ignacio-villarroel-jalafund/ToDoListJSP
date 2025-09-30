<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div id="confirmModal" style="display: none; position:fixed; top: 0; left: 0; width: 100%;
height: 100%; background-color: rgba(0,0,0,0.5); justify-content: center; align-items: center;">

    <div style="background-color: #fff; padding: 20px; border-radius: 10px; width: 300px; text-align: center;">
        <h3 id="confirmTitle">Are you sure?</h3>
        <p id="confirmText">Confirm action</p>
        <button onclick="confirmAction()">Confirm</button>
        <button onclick="closeConfirm()">Cancel</button>
    </div>
</div>

<script>
    let formToSubmit = null;

    function openConfirm(formId, title, message) {
        formToSubmit = document.getElementById(formId);
        document.getElementById("confirmTitle").innerText = title;
        document.getElementById("confirmText").innerText = message;
        document.getElementById("confirmModal").style.display = "flex";
    }

    function closeConfirm() {
        document.getElementById("confirmModal").style.display = "none";
        formToSubmit = null;
    }

    function confirmAction() {
        if (formToSubmit) {
            formToSubmit.submit();
        }
        closeConfirm();
    }
</script>