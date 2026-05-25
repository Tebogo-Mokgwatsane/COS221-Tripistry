const tabs = document.querySelectorAll(".tab");
const slider = document.getElementById("slider");
const blackPlane = document.getElementById("black-plane");
const grayPlane = document.getElementById("gray-plane");
const blackBrief = document.getElementById("black-brief");
const grayBrief = document.getElementById("gray-brief");
const form = document.getElementById("form");
const emailInput = document.getElementById("email");
const passwordInput = document.getElementById("password");
const emailError = document.getElementById("email-error");
const passwordError = document.getElementById("password-error");
const welcome = document.getElementById("welcome");

let activeTab = "traveller";

// Form submit
form.addEventListener("submit", function (e) {
    e.preventDefault();
    handleLogin();
});

// Tab switching
tabs.forEach((tab, index) => {
    tab.addEventListener("click", () => {
        tabs.forEach(t => t.classList.remove("active"));
        tab.classList.add("active");

        if (index === 1) {
            slider.classList.add("right");
            blackPlane.style.display = "none";
            grayPlane.style.display = "inline-block";
            grayBrief.style.display = "none";
            blackBrief.style.display = "inline-block";
            activeTab = "agency";
            welcome.textContent = "Welcome back, partner";
        } else {
            slider.classList.remove("right");
            blackPlane.style.display = "inline-block";
            grayPlane.style.display = "none";
            grayBrief.style.display = "inline-block";
            blackBrief.style.display = "none";
            activeTab = "traveller";
            welcome.textContent = "Welcome back";
        }
    });
});

function handleLogin() {
    const email = emailInput.value.trim();
    const password = passwordInput.value.trim();

    emailError.textContent = "";
    passwordError.textContent = "";

    const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;

    if (!emailRegex.test(email)) {
        emailError.textContent = "Enter a valid email address";
        return;
    }

    if (!password) {
        passwordError.textContent = "Password is required";
        return;
    }

    const expectedUserType = activeTab === "agency" ? "travel_agent" : "traveller";

    fetch("http://localhost/COS221-Tripistry/api.php", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
            type: "Login",
            email: email,
            password: password,
            expected_user_type: expectedUserType
        })
    })
    .then(res => res.json())
    .then(data => {
        if (data.status === "success") {

            const actualUserType = data.data.user_type;

            // Block wrong account type for selected tab
            if (expectedUserType === "traveller" && actualUserType === "travel_agent") {
                localStorage.removeItem("user");
                document.cookie = "apiKey=; path=/; max-age=0";
                alert("This is an agency account. Please login using the Partner tab.");
                return;
            }

            if (expectedUserType === "travel_agent" && actualUserType === "traveller") {
                localStorage.removeItem("user");
                document.cookie = "apiKey=; path=/; max-age=0";
                alert("This is a traveller account. Please login using the Traveller tab.");
                return;
            }

            // Save user
            localStorage.setItem("user", JSON.stringify({
                username: data.data.username,
                user_type: actualUserType
            }));

            // Store API key in cookie for 5 hours
            document.cookie = `apiKey=${data.data.apikey}; path=/; max-age=18000`;

<<<<<<< Updated upstream
            alert("Welcome back, " + data.data.username + "!");

            if (data.data.user_type === "travel_agent") {
                window.location.href = "Tripistry/agent.html";
            } else {
                window.location.href = "Tripistry/traveller.html";
=======
            // Redirect based on role
            if (actualUserType === "travel_agent") {
                window.location.href = "/COS221-Tripistry/agency/index.php";
            } else if (actualUserType === "traveller") {
                window.location.href = "/COS221-Tripistry/traveller/";
            } else {
                alert("Unknown user type.");
>>>>>>> Stashed changes
            }

        } else {
            alert(data.message || "Login failed");
        }
    })
    .catch(err => {
        console.error(err);
        alert("Error connecting to server. Please try again.");
    });
}