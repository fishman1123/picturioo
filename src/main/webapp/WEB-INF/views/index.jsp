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

        .modalOverlay {
            display: none; /* Hidden by default */
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.7);
            z-index: 1000; /* On top of other elements */
        }

        .modalContainer {
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            width: 400px;
            padding: 20px;
            z-index: 1001;
        }

        .modalHeader, .modalFooter {
            padding: 10px 0;
        }

        .modalBody {
            padding: 20px 0;
        }

        #modalImage img {
            max-height: 500px;
        }
    </style>
    <script type="text/javascript">
        let editTrigger = false;
        let originalModalContent = '';

        document.addEventListener('DOMContentLoaded', () => {
            fetch('/image/all')
                .then(response => response.json())
                .then(data => {
                    const container = document.getElementById("imageContainer");
                    data.forEach(image => {
                        const buttonElement = document.createElement('button');
                        buttonElement.classList.add("defaultButton");
                        buttonElement.style.width = "auto";
                        buttonElement.style.height = "120px";
                        buttonElement.style.padding = "0";

                        const imgElement = document.createElement('img');
                        imgElement.src = image.imgUrl;  // Use the imgUrl directly
                        imgElement.alt = image.userName;
                        imgElement.style.width = '100%';
                        imgElement.style.height = '100%';
                        buttonElement.onclick = () => showModal(imgElement);
                        container.appendChild(buttonElement);
                        buttonElement.appendChild(imgElement);
                    });
                })
                .catch(error => console.error('Error fetching images:', error));
        });

        const showModal = (imageElement) => {
            const modalImage = document.getElementById('modalImage');
            modalImage.innerHTML = '';
            const img = document.createElement('img');
            img.src = imageElement.src;
            img.alt = imageElement.alt;
            img.style.width = '100%';
            modalImage.appendChild(img);
            document.getElementById('modalPage').style.display = 'block';

            // Store original content for undo
            originalModalContent = document.getElementById('imageContent').innerHTML;
            editTrigger = false;  // Ensure edit mode is off initially
        }

        const closeModal = () => {
            document.getElementById('modalPage').style.display = 'none';
        }

        const editPageTransition = () => {
            const modalImage = document.querySelector('#modalImage img');
            const editMainPlate = document.getElementById('imageContent');

            if (editTrigger) {
                // Undo the edit: restore original content
                editMainPlate.innerHTML = originalModalContent;
                editTrigger = false;
            } else {
                // Save original content before editing
                originalModalContent = editMainPlate.innerHTML;

                const editImageContainer = document.createElement('form');
                editImageContainer.method = "post";
                editImageContainer.action = "/image/edit"
                editImageContainer.classList.add('fileUploadContainer');
                editImageContainer.innerHTML = `
                    <img id="imagePreview" src="" alt="Logo" style="width: 100%; padding-bottom: 10px; cursor: pointer; margin: auto"/>
                    <input type="file" id="imageInput" class="padded-input" accept="image/*" style="display: none;" name="targetImage"/>
                    <label for="imageInput" style="cursor: pointer;">이미지 선택</label>
                    <button class="defaultButton" onclick="cancelEdit()">수정취소</button>
                    <button type="submit" class="defaultButton" onclick="">저장하기</button>
                `;

                editMainPlate.innerHTML = '';
                editMainPlate.appendChild(editImageContainer);

                // Set image preview src to modal image src
                const imagePreview = document.getElementById('imagePreview');
                imagePreview.src = modalImage.src;

                // Add event listener to input
                const imageInput = document.getElementById('imageInput');
                imageInput.addEventListener('change', (event) => {
                    const reader = new FileReader();
                    reader.onload = (e) => {
                        imagePreview.src = e.target.result;
                    };
                    reader.readAsDataURL(event.target.files[0]);
                });

                // Trigger file input click when image is clicked
                imagePreview.addEventListener('click', () => {
                    imageInput.click();
                });

                editTrigger = true;
            }
        }

        const cancelEdit = () => {
            document.getElementById('imageContent').innerHTML = originalModalContent;
            editTrigger = false;
        }

        // const saveImage = () => {
        //     fetch("/")
        // }
    </script>
</head>
<body>
<div class="mainPlate"
     style="display: flex; justify-content: center; align-items: center; background-color: aqua; width: 100vw; height: 100vh">
    <div style="height: 90%; width: 100%; margin-left: 60px; margin-right: 60px" class="mainPageTemplate">
        <h1>THIS IS MAIN</h1>
        <button class="defaultButton" onclick="hello()" role="button">눌러봐라</button>
        <button class="defaultButton" style="margin: 0 20px 0 20px" onclick="location.href = '/'">Go to Main</button>
        <button class="defaultButton" style="margin: 0 20px 0 20px" onclick="location.href = '/upload/create'">Go Upload</button>

        <div style="margin-top: 50px">
            <h3>테스트</h3>
            <div id="imageContainer"></div>
        </div>
        <div id="modalPage" class="modalOverlay">
            <div id="imageContent" class="modalContainer">
                <div id="modalImage" class="modalHeader">
                    <img src="" alt="Modal Image" style="width: 100%;">
                </div>
                <div class="modalBody">
                    <p>TEST</p>
                </div>
                <div class="modalFooter">
                    <button class="defaultButton" onclick="editPageTransition()">수정하기</button>
                    <button class="defaultButton" onclick="closeModal()">Close</button>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
