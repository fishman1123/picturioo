<%--
  Created by IntelliJ IDEA.
  User: yongjoocho
  Date: 2024. 7. 22.
  Time: 오후 5:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<link rel="stylesheet" type="text/css" href="/css/styles.css">

<script type="text/javascript">
    const hello = () => {
        console.log("yoooo");
    }
</script>
<head>
    <title>Title</title>
</head>
<body>
<div class="mainPlate" style="display: flex; justify-content: center; align-items: center; background-color: aqua; width: 100vw; height: 100vh">
    <div>
        <button class="mainButton" onclick="hello()"></button>
        <h1>THIS IS MAIN</h1>
    </div>
    <!-- HTML !-->
    <button class="defaultButton" role="button">눌러봐라</button>


    <div style="margin-top: 300px" class="mainPageTemplate">YO</div>



</div>

</body>
</html>
