
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core"  prefix="c" %>

<html>
<link rel="stylesheet" type="text/css" href="/css/styles.css">

<script type="text/javascript">
    const hello = () => {
        console.log("ㅗㅗㅗㅗㅗㅗㅗㅗ");
        document.getElementById("hey").innerText = "ㅗ";
    }
</script>
<head>
    <title>Title</title>
</head>

<body>
<div class="mainPlate" style="display: flex; justify-content: center; align-items: center; background-color: aqua; width: 100vw; height: 100vh">


    <div style=" height: 500px; width: 100%; margin-left: 100px; margin-right: 100px" class="mainPageTemplate">
        <h1>THIS IS MAIN</h1>
        <button class="defaultButton" sty onclick="hello()" role="button">눌러봐라</button>
<%--        <div style=" height: 100%; margin-top: 20px">--%>
<%--            <div class="imageBlock">WOHHHHH</div>--%>



<%--        </div>--%>
        <div style="margin-top: 50px">
            <h3>테스트</h3>
            <c:if test="${imgSet != null}">
                이름: ${imgSet.userName}
            </c:if>
            <c:if test="${imgSet == null}">
                <h1>왜 안나옴?</h1>
            </c:if>
            <h1 id="hey"></h1>

        </div>

    </div>



</div>

</body>
</html>
