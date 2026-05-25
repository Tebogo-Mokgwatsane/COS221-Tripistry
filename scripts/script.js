// first check if a user is logged in, if it is you redirect to the appropriate page
const user = JSON.parse(localStorage.getItem("user"));
console.log(user);
if (user !== null){
    console.log(user)
    if (user.user_type === "traveller"){
        window.location.href = "traveller/"
    } else if (user.user_type === "travel_agent"){
        window.location.href = "agency/"
    } else {
        localStorage.removeItem("user")
    }
}

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
