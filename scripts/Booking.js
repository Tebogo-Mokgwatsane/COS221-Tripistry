var package_id = 1; // for testing only
var lastTotalPrice = 0;
var bookingAvailable = false;

function getPackageId()
{
    var params = new URLSearchParams(window.location.search);
    var id = params.get("package_id");
    if (id != null)
    {
        package_id = Number(id);
    }
}
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

    req.open("POST","api.php", true);
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
    var email = document.getElementById("email").value;
    var quantity = Number(document.getElementById("quantity").value);
    var response = document.getElementById("response");
    var paymentLink = document.getElementById("paymentLink");

    paymentLink.style.display = "none";

    if (email == "")
    {
        response.textContent = "Please enter your email.";
        response.style.color = "red";
        return;
    }

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
                    response.textContent = "Booking successful. You can now proceed to payment.";
                    response.style.color = "green";
                    paymentLink.style.display = "block";

                    var booking=ob.data.Booking_id;
                    localStorage.setItem("bookingResponse", JSON.stringify(ob));
                    localStorage.setItem("bookingTotalPrice",ob.data.total_price);
                    localStorage.setItem("Booking_id",booking);
                }
                else
                {
                    response.textContent = ob.message;
                    response.style.color = "red";
                    paymentLink.style.display = "none";
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
                    response.textContent = "Booking failed. Check your API.";
                }

                response.style.color = "red";
                paymentLink.style.display = "none";
            }
        }
    };
    req.open("POST","api.php", true);
    req.setRequestHeader("Content-Type", "application/json");
    var body = {
        type: "Booking",
        Email: email,
        package_id: package_id,
        Quantity: quantity
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
                    image.src = ob.data.img_url;
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

    req.open("POST", "api.php", true);
    req.setRequestHeader("Content-Type", "application/json");

    var body = 
    {
        type: "Pacakgeinfo",
        package_id: package_id
    };

    req.send(JSON.stringify(body));
}
window.onload = function()
{
    getPackageId();

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