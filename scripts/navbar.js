const exploreBtn = document.getElementById("explore-btn");
const dropDown = document.getElementById("dropdown");

exploreBtn.addEventListener("click", (e) => {
    e.stopPropagation();
    dropDown.style.display = getComputedStyle(dropDown).display === "none" ? "block" : "none";
})

document.addEventListener("click", () => {
    dropDown.style.display = "none";
});
document.addEventListener("scroll", () => {
    dropDown.style.display = "none";
}); 

const user = JSON.parse(localStorage.getItem("user"));
if (user !== null){
    const firstName = user.username.split(" ")[0];
    const username = document.getElementById("username");
    username.textContent = firstName;
}

// logout
const overlay = document.getElementById("logout-overlay");
const openBtn = document.getElementById("logout");
const closeBtn = document.getElementById("cancel-button");
const logoutBtn = document.getElementById("confirm-button");
// const section = document.getElementById("login-section");

openBtn.addEventListener("click", () => {

  overlay.classList.remove("logout-hidden");
});

closeBtn.addEventListener("click", () => {
  overlay.classList.add("logout-hidden");
});

overlay.addEventListener("click", (e) => {
  if (e.target === overlay) {
    overlay.classList.add("logout-hidden");
  } 
});

logoutBtn.addEventListener("click", (e) => {
    localStorage.removeItem("user");
    window.location.href = "/";
})
; 
