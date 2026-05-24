const user = JSON.parse(localStorage.getItem("user"));

if (user === null){
    window.location.href = "/login.html"
}
if (user.user_type !== "traveller"){
    if (user.user_type === "agency"){
        window.location.href = "/agency/";
    } else {
        localStorage.removeItem("user");
        window.location.href = "/login.html";    
    }

}

// loading the username
const username = document.getElementById("username") || document.getElementById("packages-username");
username.textContent = user.name;

    
//fixing some css issues
const loginSection = document.getElementById("login-section");
loginSection.style.gap = "7px";



