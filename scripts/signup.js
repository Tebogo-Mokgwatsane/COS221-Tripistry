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

const signup = async (formData) => {
    const res = await fetch('/api.php', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(formData)
    });

    const data = await res.json();

    if (data.status === "success"){
        console.log(data);
    } else {
        console.log(data);
    }
    // .then(data => {
    //     if (data.status === "success") {

    //         //localStorage??
    //         localStorage.setItem('user', JSON.stringify({
    //             username: formData.username,
    //             email: formData.email,
    //             user_type: formData.user_type
    //         }));

    //         alert("🧳Registration Successful!");
    //         window.location.href = "login.html";
    //     } else {
    //         alert(data.message || "Registration failed");
    //     }
    // })
    // .catch(err => {
    //     console.error(err);
    //     alert("Error. Please try again.");
    // });
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

    const emailRegex = /^[a-zA-Z0-9._% +-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
    const passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{8,}$/;
    

    if (fname.value.trim().length < 2 || lname.value.trim().length < 2){
        fnameError.textContent = "First and last name need to be at least 2 characters long"
    } else {
        fnameError.textContent = "";
        if (!emailRegex.test(email.value)){
            emailError.textContent = "Enter a valid email address";
        } else {
            emailError.textContent = "";
            if (!passwordRegex.test(password.value)){
                passwordError.textContent = "Password should be at least 8 characters long, contain upper and lower case letters, at least one digit and one symbol."
                passwordError.style.marginBottom = "15px";
            } else {
                passwordError.textContent = "";
                passwordError.style.marginBottom = "0";

                const formData = {
                    type: "Register",
                    username: fname.value.trim() + " " + lname.value.trim(),
                    email: email.value.trim(),
                    password: password.value,
                    user_type: activeTab // "traveller" or "travel_agent" based on active tab
                };

                signup(formData);
            }
        }
    
    }



    //  sending data to api
    

    
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