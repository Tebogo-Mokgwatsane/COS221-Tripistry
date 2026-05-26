const current_user = JSON.parse(localStorage.getItem("user"));
if (current_user === null) window.location.href = "/";
if (current_user.user_type === "travel_agent") window.location.href = "/agency";