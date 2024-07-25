
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core"  prefix="c" %>

<html>
<link rel="stylesheet" type="text/css" href="/css/styles.css">

<script type="text/javascript">
    const hello = () => {
        console.log("ㅗㅗㅗㅗㅗㅗㅗㅗ");
        document.getElementById("hey").innerText = "ㅎㅇㅌ";
    }



</script>
<head>
    <title>Title</title>
</head>

<body>
<div class="mainPlate" style="display: flex; justify-content: center; align-items: center; background-color: aqua; width: 100vw; height: 100vh">


    <div style=" height: 500px; width: 100%; margin-left: 100px; margin-right: 100px" class="mainPageTemplate">
        <h1>THIS IS MAIN</h1>
        <button class="defaultButton" onclick="hello()" role="button">눌러봐라</button>

        <button class="defaultButton" style="margin: 0 20px 0 20px" onclick="location.href = '/upload/create'">Go to Main</button>

        <div style="margin-top: 50px">
            <h3>테스트</h3>

            <div>
                <c:if test="${ !empty list }">
                    <c:forEach items="${list }" var="image">
                        <div style="height: 10px; width: 100px"><h1>${image.userName}</h1></div>
                    </c:forEach>
                </c:if>
            </div>





        </div>

    </div>



</div>

</body>
</html>
