const tabs = document.querySelectorAll(".tab");
const slider = document.getElementById("slider");
const blackPlane = document.getElementById("black-plane");
const grayPlane = document.getElementById("gray-plane");
const blackBrief = document.getElementById("black-brief");
const grayBrief = document.getElementById("gray-brief");
const form = document.getElementById("form");
const email = document.getElementById("email");
const password = document.getElementById("password");
const emailError = document.getElementById("email-error");
const passwordError = document.getElementById("password-error");
const welcome = document.getElementById("welcome");

let activeTab = "traveller";

form.addEventListener("submit", (e) => {
    e.preventDefault();

    const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
    const passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{8,}$/;

    if (!emailRegex.test(email.value)){
        emailError.textContent = "Enter a valid email address";
    } else {
        emailError.textContent = "";
        // TODO: make request
    }
})

tabs.forEach((tab, index) => {

    tab.addEventListener("click", () => {

        tabs.forEach(t => t.classList.remove("active"));
        tab.classList.add("active");

        if(index === 1){
            slider.classList.add("right");
            blackPlane.style.display = "none";
            grayPlane.style.display = "inline-block";
            grayBrief.style.display = "none";
            blackBrief.style.display = "inline-block";
            activeTab = "agency";
            welcome.textContent = "Welcome back, partner"

        } else {
            slider.classList.remove("right");
            blackPlane.style.display = "inline-block";
            grayPlane.style.display = "none";
            grayBrief.style.display = "inline-block";
            blackBrief.style.display = "none";
            activeTab = "traveller"
            welcome.textContent = "Welcome back"
        }

    });

});

function handleLogin() {
    const email = document.getElementById('email').value.trim();
    const password = document.getElementById('password').value.trim();

    if (!email || !password) {
        //alert("Please fill in all fields");
        return;
    }

    fetch('api.php', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
            type: "Login",
            email: email,
            password: password
        })
    })
    //.then(res => res.json())
    .then(res => {//debugging
    return res.text().then(text => {
        try {
            return JSON.parse(text);
        } catch (err) {
            console.error("The raw server login response was:", text);
            throw new Error("Server did not return valid JSON");
        }
    });
    })
    .then(data => {
        if (data.status === "success") {
            const selectedType = activeTab;                    // "traveller" or "agency" to correspond with slider in html
            const userType = data.data.user_type;

            //User type should match selected tab
            if ((selectedType === "traveller" && userType !== "traveller") || (selectedType === "agency" && (userType !== "travel_agent"))) {
               // alert("Wrong account type. Please select the correct tab.");
                return;
            }

            // Save to localStorage
            localStorage.setItem('user', JSON.stringify({
                username: data.data.username,
                user_type: userType,
                email: data.data.email
            }));

            // Store API key in cookie
            document.cookie = `apiKey=${data.data.apikey}; path=/; max-age=18000`;//expires in 5hrs

            //alert("Welcome back, " + data.data.username + "!");

            if (userType === "travel_agent") {
                window.location.href = "agency/index.php";
            } else {
                window.location.href = "traveller/index.php";
            }

        } else {
           // alert(data.message || "Login failed");
           console.error("Login failed:", data);
           passwordError.textContent = "Invalid email or password";
        }
    })
    .catch(err => {
        console.error(err);
        console.error("The raw server login response was:", err);
        //alert("Error connecting to server. Please try again.");
    });
}