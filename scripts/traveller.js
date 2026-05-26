

// loading the username
if(!username){username = document.getElementById("username") || document.getElementById("packages-username");}
//const username = document.getElementById("username") || document.getElementById("packages-username");
if (username) {
    username.textContent = user.username || "Traveller";
}

//fixing some css issues
const loginSection = document.getElementById("login-section");
loginSection.style.gap = "7px";



