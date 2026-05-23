function handleSearch() {
    const query = document.getElementById('search-input').value.trim();
    
    if (!query) {
        alert("Please enter a search term");
        return;
    }

    fetch('api.php', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
            type: "Search",
            query: query
        })
    })
    .then(res => res.json())
    .then(data => {
        if (data.status === "success") {
            console.log("Search results:", data.data);
            // Your partner can render results here later
            renderSearchResults(data.data);
        } else {
            alert(data.message || "No results found");
        }
    })
    .catch(err => console.error(err));
}

// Example render function (your partner can improve)
function renderSearchResults(results) {
    console.log("Displaying", results.length, "results");
    // Example: alert for testing
    alert(`Found ${results.length} packages! Check console for details.`);
}