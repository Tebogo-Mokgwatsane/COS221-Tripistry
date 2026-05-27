// some elements for DOM manipulation
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
const travellerForm = document.getElementById("traveller-form");
const agencyForm = document.getElementById("agency-form");
const agencyName = document.getElementById("agency-name");
const agencyEmail = document.getElementById("agency-email");
const agencyPassword = document.getElementById("agency-password");
const registrationNum = document.getElementById("registration-num");
const agenterr = document.getElementById("registration-num-error");

// functions to handle switching user login and signup

let activeTab = "traveller";// or travel_agent. currently only traveller reflects in db

const switchToTraveller = () => {
    slider.classList.remove("right");
    blackPlane.style.display = "inline-block";
    grayPlane.style.display = "none";
    grayBrief.style.display = "inline-block";
    blackBrief.style.display = "none";
    activeTab = "traveller";
    agencyForm.style.display = "none";
    travellerForm.style.display = "block";
    fname.required = true;
    lname.required = true;
    email.required = true;
    password.required = true;
    agencyName.required = false;
    agencyEmail.required = false;
    agencyPassword.required = false;
    agencyEmail.required = false;
}

const switchToAgency = () => {
    slider.classList.add("right");
    blackPlane.style.display = "none";
    grayPlane.style.display = "inline-block";
    grayBrief.style.display = "none";
    blackBrief.style.display = "inline-block";
    activeTab = "travel_agent";
    agencyForm.style.display = "block";
    travellerForm.style.display = "none";
    fname.required = false;
    lname.required = false;
    email.required = false;
    password.required = false;
    agencyName.required = true;
    agencyEmail.required = true;
    agencyPassword.required = true;
    agencyEmail.required = true;
}

const type = localStorage.getItem("type");
if (type !== null){
    if (type === "agency"){
        tabs.forEach(t => t.classList.remove("active"));
        tabs[1].classList.add("active");
        localStorage.removeItem("type");
        switchToAgency();
    }
}

form.addEventListener("submit", (e) => {
    e.preventDefault();

    let formData = {
        type: "Register",
        user_type: activeTab
    };

    const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
    const passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{8,}$/;

    if (activeTab === "traveller") {
        const fname = document.getElementById("fname").value.trim();
        const lname = document.getElementById("lname").value.trim();
        const email = document.getElementById("email").value.trim();
        const password = document.getElementById("password").value.trim();

        if (fname.length < 2 || lname.length < 2) {
            fnameError.textContent = "First and last name need to be at least 2 characters long";
            return;
        } else {fnameError.textContent = "";}

        if (!emailRegex.test(email)){
            emailError.textContent = "Enter a valid email address";
            return;
        } else {emailError.textContent = "";}

        if (!passwordRegex.test(password)){
            passwordError.textContent = "Password should be at least 8 characters long, contain upper and lower case letters, at least one digit and one symbol."
            passwordError.style.marginBottom = "15px";
            return;
        } else {passwordError.textContent = ""; passwordError.style.marginBottom = "0";}

        formData.username = fname + " " + lname;
        formData.fname= fname;
        formData.lname= lname;
        formData.email = email;
        formData.password = password;

    } else { // Agency
        const agencyName = document.getElementById("agency-name").value.trim();
        const email = document.getElementById("agency-email").value.trim();
        const password = document.getElementById("agency-password").value.trim();
        const regNum = document.getElementById("registration-num").value.trim();

        if (!agencyName || !email || !password || !regNum) {
            //alert("All agency fields are required");// since we dont have error elements for agency form, using alert for now
            agenterr.textContent = "All agency fields are required";
            return;
        }

        formData.username = agencyName;
        formData.email = email;
        formData.password = password;
        formData.registration_num = regNum;
        formData.agency_name = agencyName;
    }

    //Sending data to api
    fetch('api.php', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(formData)
    })
    /*.then(res => res.json())
    /*.then(res => {//debugging
    return res.text().then(text => {
        try {
            return JSON.parse(text);
        } catch (err) {
            console.error("The raw server login response was:", text);
            throw new Error("Server did not return valid JSON");
        }
    });
    })*/
    .then(res => res.text())
    .then(text => {
        console.log("Raw Response:", text);   // ← Debug
        try {
            return JSON.parse(text);
        } catch (e) {
            throw new Error("Invalid JSON response");
        }
    })
    .then(data => {
        if (data.status === "success") {
            localStorage.setItem('user', JSON.stringify({
                fname: data.data.username.split(" ")[0],
                apikey: data.data.apikey,
                email: data.data.email,
                username: formData.username,
                user_type: formData.user_type
            }));
            //alert("Registration works");//For testing purposes
            if (formData.user_type === "travel_agent") {
                window.location.href = "agency/index.php";
            } else if (formData.user_type === "traveller"){
                window.location.href = "traveller/index.php";
            } else {
            window.location.href = "login.html";
            }
        } else {
            //alert(data.message || "Registration failed");//for testing purposes
            console.error("Registration failed:", data);
            agenterr.textContent = "Invalid or unlicensed registration number provided.";
        }
    })
    .catch(err => {
        console.error(err);
        //alert("Error connecting to server.");///catch stmt
        console.error("Error connecting to server.", err);
    });
});

tabs.forEach((tab, index) => {

    tab.addEventListener("click", () => {

        tabs.forEach(t => t.classList.remove("active"));
        tab.classList.add("active");

        if(index === 1){
            switchToAgency();
        } else {
            switchToTraveller();
        }

    });

});