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