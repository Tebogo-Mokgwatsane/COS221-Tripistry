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

let userr = JSON.parse(localStorage.getItem("user"));
if (userr !== null){

    username.textContent = userr.fname;
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
