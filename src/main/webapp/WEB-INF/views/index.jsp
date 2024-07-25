<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" type="text/css" href="/css/styles.css">
    <style>
        body {
            font-family: Arial, sans-serif;
        }

        .modal-overlay {
            display: none; /* Hidden by default */
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.7); /* Darkish background */
            z-index: 1000; /* On top of other elements */
        }

        .modal-container {
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background: white;
            padding: 20px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
            z-index: 1001; /* On top of the overlay */
        }

        .modal-header, .modal-footer {
            padding: 10px 0;
        }

        .modal-body {
            padding: 20px 0;
        }

        .close-button {
            background: #ff5c5c;
            border: none;
            color: white;
            padding: 5px 10px;
            cursor: pointer;
        }
    </style>
    <script type="text/javascript">
        document.addEventListener('DOMContentLoaded', () => {
            fetch('/image/all')
                .then(response => response.json())
                .then(data => {
                    const container = document.getElementById("imageContainer");
                    console.log(data);
                    data.forEach(image => {
                        const buttonElement = document.createElement('button');
                        buttonElement.classList.add("defaultButton");
                        buttonElement.style.width = "auto";
                        buttonElement.style.height = "120px";
                        buttonElement.style.padding = "0";
                        buttonElement.onclick = () => showModal();

                        const imgElement = document.createElement('img');
                        imgElement.src = image.imgUrl;  // Use the imgUrl directly
                        imgElement.alt = image.userName;
                        imgElement.style.width = '100%';
                        imgElement.style.height = '100%';
                        container.appendChild(buttonElement);
                        buttonElement.appendChild(imgElement);
                    });
                })
                .catch(error => console.error('Error fetching images:', error));
        });

        function showModal() {
            document.getElementById('modalOverlay').style.display = 'block';
        }

        function closeModal() {
            document.getElementById('modalOverlay').style.display = 'none';
        }
    </script>
</head>
<body>
<div class="mainPlate" style="display: flex; justify-content: center; align-items: center; background-color: aqua; width: 100vw; height: 100vh">
    <div style="height: 500px; width: 100%; margin-left: 60px; margin-right: 60px" class="mainPageTemplate">
        <h1>THIS IS MAIN</h1>
        <button class="defaultButton" onclick="hello()" role="button">눌러봐라</button>
        <button class="defaultButton" style="margin: 0 20px 0 20px" onclick="location.href = '/'">Go to Main</button>
        <button class="defaultButton" style="margin: 0 20px 0 20px" onclick="location.href = '/upload/create'">Go Upload</button>

        <div style="margin-top: 50px">
            <h3>테스트</h3>
            <div id="imageContainer"></div>
        </div>

        <button class="defaultButton" onclick="showModal()">Open Modal</button>

        <div id="modalOverlay" class="modal-overlay">
            <div class="modal-container">
                <div class="modal-header">
                    <h2>Modal Title</h2>
                </div>
                <div class="modal-body">
                    <p>TEST</p>
                </div>
                <div class="modal-footer">
                    <button class="defaultButton" onclick="closeModal()">Close</button>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
