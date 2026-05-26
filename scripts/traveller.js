if (user === null){
    window.location.href = "../login.html"
}
if (user.user_type !== "traveller"){
    if (user.user_type === "agency"|| user.user_type === "travel_agent"){
        window.location.href = "../agency/";
    } else {
        localStorage.removeItem("user");
        window.location.href = "../login.html";    
    }

}

// loading the username
if(!username){username = document.getElementById("username") || document.getElementById("packages-username");}
//const username = document.getElementById("username") || document.getElementById("packages-username");
if (username) {
    username.textContent = user.username || "Traveller";
}

//fixing some css issues
const loginSection = document.getElementById("login-section");
loginSection.style.gap = "7px";



