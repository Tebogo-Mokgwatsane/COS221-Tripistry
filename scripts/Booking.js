const params = new URLSearchParams(window.location.search);
const id = params.get("package_id");

if (id === null){
    window.location.href = "index.php";
}

const user = JSON.parse(localStorage.getItem("user"));
if (user === null) window.location.href = "../login.html";



var package_id = id; // for testing only
var lastTotalPrice = 0;
var bookingAvailable = false;

function checkBooking()
{
    var quantity = Number(document.getElementById("quantity").value);
    var totalPrice = document.getElementById("totalPrice");
    var response = document.getElementById("response");
    var paymentLink = document.getElementById("paymentLink");

    paymentLink.style.display = "none";
    bookingAvailable = false;
    if (quantity <= 0)
    {
        totalPrice.textContent = "0";
        response.textContent = "Please enter a valid number of packages.";
        response.style.color = "red";
        return;
    }
    localStorage.setItem("Quantity",quantity);
    var req = new XMLHttpRequest();
    req.onreadystatechange = function()
    {
        if (req.readyState == 4)
        {
            console.log(req.responseText);
            if (req.status == 200)
            {
                var ob = JSON.parse(req.responseText);
                if (ob.status == "success")
                {
                    lastTotalPrice = ob.data.total_price;
                    bookingAvailable = true;

                    totalPrice.textContent = lastTotalPrice;
                    response.textContent = "Package is available. Total price is R" + lastTotalPrice;
                    response.style.color = "green";
                }
                else
                {
                    totalPrice.textContent = "0";
                    response.textContent = ob.message;
                    response.style.color = "red";
                }
            }
            else
            {
                try
                {
                    var errorOb = JSON.parse(req.responseText);
                    response.textContent = errorOb.message;
                }
                catch(e)
                {
                    response.textContent = "Could not check package availability.";
                }
                totalPrice.textContent = "0";
                response.style.color = "red";
            }
        }
    };


    req.open("POST","/COS221-Tripistry/api.php", true);

   
    req.setRequestHeader("Content-Type", "application/json");
    var body = {
        type: "CheckBooking",
        package_id: package_id,
        Quantity: quantity
    };
    req.send(JSON.stringify(body));
}

    function confirmBooking()
{
    if (!user || !user.email) {
        window.location.href = "/COS221-Tripistry/login.html";
        return;
    }

    var quantity = Number(document.getElementById("quantity").value);
    var response = document.getElementById("response");
    var paymentLink = document.getElementById("paymentLink");

    paymentLink.style.display = "none";

    if (quantity <= 0)
    {
        response.textContent = "Please enter a valid number of packages.";
        response.style.color = "red";
        return;
    }

    if (bookingAvailable == false)
    {
        response.textContent = "Please check package availability first.";
        response.style.color = "red";
        return;
    }

    var req = new XMLHttpRequest();
    req.onreadystatechange = function()
    {
        if (req.readyState == 4)
        {
            console.log(req.responseText);
            if (req.status == 200)
            {
                var ob = JSON.parse(req.responseText);

                if (ob.status == "success")
                {
                    response.textContent = "✓ Booking Confirmed! You can now proceed to payment.";
                    response.style.color = "green";
                    response.style.fontWeight = "bold";
                    response.style.fontSize = "18px";
                    paymentLink.style.display = "block";

                    var booking = ob.data.Booking_id;
                    localStorage.setItem("bookingResponse", JSON.stringify(ob));
                    localStorage.setItem("bookingTotalPrice", ob.data.total_price);
                    localStorage.setItem("Booking_id", booking);
                }
                else
                {
                    response.textContent = ob.data || ob.message || "Booking failed.";
                    response.style.color = "red";
                    response.style.fontWeight = "normal";
                    response.style.fontSize = "16px";
                    paymentLink.style.display = "none";
                }
            }
            else
            {
                try
                {
                    var errorOb = JSON.parse(req.responseText);
                    response.textContent = errorOb.data || errorOb.message || "Booking failed.";
                }
                catch(e)
                {
                    response.textContent = "Booking failed. Check your API.";
                }

                response.style.color = "red";
                response.style.fontWeight = "normal";
                response.style.fontSize = "16px";
                paymentLink.style.display = "none";
            }
        }
    };


    req.open("POST", "/COS221-Tripistry/api.php", true);

    req.setRequestHeader("Content-Type", "application/json");

    var body = {
        type:       "Booking",
        Email:      user.email,
        package_id: package_id,
        Quantity:   quantity
    };

    req.send(JSON.stringify(body));
}
function packageInfo()
{
    var title = document.getElementById("title");
    var description = document.getElementById("description");
    var image = document.getElementById("packageImage");

    var req = new XMLHttpRequest();

    req.onreadystatechange = function()
    {
        if (req.readyState == 4)
        {
            console.log(req.responseText);

            if (req.status == 200)
            {
                var ob = JSON.parse(req.responseText);

                if (ob.status == "success")
                {
                    title.textContent = ob.data.title;
                    description.textContent = ob.data.description;

                    image.src = "/COS221-Tripistry/" +ob.data.img_url;

                    image.alt = ob.data.title;
                }
                else
                {
                    title.textContent = "Package not found";
                    description.textContent = ob.message;
                    image.style.display = "none";
                }
            }
            else
            {
                try
                {
                    var errorOb = JSON.parse(req.responseText);
                    title.textContent = "Error loading package";
                    description.textContent = errorOb.message;
                }
                catch(e)
                {
                    title.textContent = "Error loading package";
                    description.textContent = "Could not load package information.";
                }

                image.style.display = "none";
            }
        }
    };


    req.open("POST", "/COS221-Tripistry/api.php", true);

    
    req.setRequestHeader("Content-Type", "application/json");

    var body = 
    {
        type: "Packageinfo",
        package_id: package_id
    };

    req.send(JSON.stringify(body));
}
window.onload = function()
{

    packageInfo();
    
    document.getElementById("paymentLink").style.display = "none";

    document.getElementById("quantity").addEventListener("input", checkBooking);

    document.querySelector(".form").addEventListener("submit", function(event)
    {
        event.preventDefault();
        confirmBooking();
    });

    checkBooking();
};