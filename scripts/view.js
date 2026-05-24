const params = new URLSearchParams(window.location.search);
const id = params.get("package_id");

const span = document.getElementById("package-id");
span.textContent = id;