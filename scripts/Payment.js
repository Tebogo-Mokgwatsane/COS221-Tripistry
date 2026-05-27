function handlePayment()
{
    var response = document.getElementById("response");
    var booking_id = localStorage.getItem("Booking_id");
    var amount = localStorage.getItem("bookingTotalPrice");
    var reference = document.getElementById("reference").value;
    var selectedMethod = document.querySelector('input[name="method"]:checked');
    var quantity=localStorage.getItem("Quantity");

    console.log("Booking_id from localStorage:", booking_id);
    console.log("Amount from localStorage:", amount);
    console.log("Number amount:", Number(amount));
    console.log("quantity:", (quantity));

    if (booking_id == null || booking_id == "")
    {
        response.textContent = "Booking ID was not found. Please make a booking first.";
        response.style.color = "red";
        return;
    }

    if (amount == null || amount == "")
    {
        response.textContent = "Booking amount was not found. Please make a booking first.";
        response.style.color = "red";
        return;
    }

    if (selectedMethod == null)
    {
        response.textContent = "Please select a payment method.";
        response.style.color = "red";
        return;
    }

    if (reference == "")
    {
        response.textContent = "Please enter payment reference.";
        response.style.color = "red";
        return;
    }
    var method = selectedMethod.value;
    var req = new XMLHttpRequest();
    req.onreadystatechange = function()
    {
        if (req.readyState == 4)
        {   console.log(req.responseText)
            if (req.status == 200)
            {
                var ob = JSON.parse(req.responseText);

                if (ob.status == "success")
                {
                    response.style.color = "green";

                    localStorage.removeItem("Booking_id");
                    localStorage.removeItem("bookingTotalPrice");
                    localStorage.removeItem("Quantity");

                    let seconds = 5;

                    response.textContent = `Payment successful. You will be redirected to your bookings in ${seconds} seconds`;
                    const countdown = setInterval(() => {
                            seconds--;
                            response.textContent = `Payment successful. You will be redirected to your bookings in ${seconds} seconds`;
                            if (seconds <= 0){
                                clearInterval(countdown);
                                window.location.href = "/COS221-Tripistry/traveller/reviews.php";
                            }

                        }, 1000);
                    }
                else
                {
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
                    response.textContent = "Payment failed. Please check your API.";
                }

                response.style.color = "red";
            }
        }
    };
    req.open("POST","/COS221-Tripistry/api.php",true);
    req.setRequestHeader("Content-Type", "application/json");

    var body = {
        type: "Payment",
        Method: method,
        Quantity:quantity,
        Booking_id: Number(booking_id),
        amount: Number(amount),
        Reference: reference
    };
    req.send(JSON.stringify(body));
}

window.onload = function()
{
    document.querySelector(".paymentForm").addEventListener("submit", function(event)
    {
        event.preventDefault();
        handlePayment();
    });
};