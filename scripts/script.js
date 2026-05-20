const travellerBtn = document.getElementById("traveller-btn");
const agencyBtn = document.getElementById("agency-btn");
const startBtn = document.getElementById("start-exploring");

travellerBtn.addEventListener("click", (e) => {
    localStorage.setItem("type", "traveller");
    window.location.href = "signup.html";
})
agencyBtn.addEventListener("click", (e) => {
    localStorage.setItem("type", "agency");
    window.location.href = "signup.html";
})

startBtn.addEventListener("click", (e) => {
    window.location.href = "login.html";
})