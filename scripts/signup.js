const tabs = document.querySelectorAll(".tab");
const slider = document.getElementById("slider");
const blackPlane = document.getElementById("black-plane");
const grayPlane = document.getElementById("gray-plane");
const blackBrief = document.getElementById("black-brief");
const grayBrief = document.getElementById("gray-brief");
const form = document.getElementById("form");
const fname = document.getElementById("fname");
const lname = document.getElementById("lname");
const email = document.getElementById("email");
const password = document.getElementById("password");
const fnameError = document.getElementById("fname-error");
const lnameError = document.getElementById("lname-error");
const emailError = document.getElementById("email-error");
const passwordError = document.getElementById("password-error");

let activeTab = "traveller";// or travel_agent. currently only traveller reflects in db

form.addEventListener("submit", (e) => {
    e.preventDefault();

    const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
    const passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{8,}$/;
    
    let isValid = true;

    if (fname.value.trim().length < 2 || lname.value.trim().length < 2){
        fnameError.textContent = "First and last name need to be at least 2 characters long"
        isValid = false;
    } 
    else {fnameError.textContent = "";}

    if (!emailRegex.test(email.value)){
        emailError.textContent = "Enter a valid email address";
        isValid = false;
    } 
    else {emailError.textContent = "";}

    if (!passwordRegex.test(password.value)){
        passwordError.textContent = "Password should be at least 8 characters long, contain upper and lower case letters, at least one digit and one symbol."
        passwordError.style.marginBottom = "15px";
        isValid = false;
    } 

    if (!isValid) return;

    //  sending data to api
    const formData = {
        type: "Register",
        username: fname.value.trim() + " " + lname.value.trim(),
        email: email.value.trim(),
        password: password.value,
        user_type: activeTab // "traveller" or "travel_agent" based on active tab
    };

    fetch('api.php', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(formData)
    })
    .then(res => res.json())
    .then(data => {
        if (data.status === "success") {

            //localStorage??
            localStorage.setItem('user', JSON.stringify({
                username: formData.username,
                email: formData.email,
                user_type: formData.user_type
            }));

            alert("🧳Registration Successful!");
            window.location.href = "login.html";
        } else {
            alert(data.message || "Registration failed");
        }
    })
    .catch(err => {
        console.error(err);
        alert("Error. Please try again.");
    });
});

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
            activeTab = "agency";//"travel_agent"; as per db

        } else {
            slider.classList.remove("right");
            blackPlane.style.display = "inline-block";
            grayPlane.style.display = "none";
            grayBrief.style.display = "inline-block";
            blackBrief.style.display = "none";
            activeTab = "traveller"
        }

    });

});