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

let activeTab = "traveller";

const type = localStorage.getItem("type");
if (type !== null){
    if (type === "agency"){
        tabs.forEach(t => t.classList.remove("active"));
        tabs[1].classList.add("active");
        localStorage.removeItem("type");
        slider.classList.add("right");
        blackPlane.style.display = "none";
        grayPlane.style.display = "inline-block";
        grayBrief.style.display = "none";
        blackBrief.style.display = "inline-block";
        activeTab = "agency";
        agencyForm.style.display = "block";
        travellerForm.style.display = "none";
    }
}

form.addEventListener("submit", (e) => {
    e.preventDefault();

    const emailRegex = /^[a-zA-Z0-9._% +-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
    const passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{8,}$/;
    
    if (fname.value.length < 2 || lname.value.length < 2){
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
                
            }
        }
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
            agencyForm.style.display = "block";
            travellerForm.style.display = "none";

        } else {
            slider.classList.remove("right");
            blackPlane.style.display = "inline-block";
            grayPlane.style.display = "none";
            grayBrief.style.display = "inline-block";
            blackBrief.style.display = "none";
            activeTab = "traveller";
            agencyForm.style.display = "none";
            travellerForm.style.display = "block";
        }

    });

});