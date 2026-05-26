const user = JSON.parse(localStorage.getItem("user")) || {};


if(!user){ user = JSON.parse(localStorage.getItem("user")) || {};}

const packagesUsername = document.getElementById("packages-username");
if (packagesUsername) {
    packagesUsername.textContent = user.username || "Traveller";
}

//logic for filtering by group/solo packages
const groupBtn = document.getElementById("group-btn");
const soloBtn = document.getElementById("solo-btn");
let groupFilter = false;
let soloFilter = false;

groupBtn.addEventListener("click", (e) => {
    if (groupBtn.classList.contains("unchecked")){
        groupBtn.classList.remove("unchecked");
        groupBtn.classList.add("checked");
        groupFilter = true;

        filterPackages();
    } else {
        groupBtn.classList.remove("checked");
        groupBtn.classList.add("unchecked");
        groupFilter = false;

        filterPackages();
    }
});

soloBtn.addEventListener("click", (e) => {
    if (soloBtn.classList.contains("unchecked")){
        soloBtn.classList.remove("unchecked");
        soloBtn.classList.add("checked");
        soloFilter = true;
        
        filterPackages();
    } else {
        soloBtn.classList.remove("checked");
        soloBtn.classList.add("unchecked");
        soloFilter = false;

        filterPackages();  
    }
});

// some mock data
let packages = [];



let filteredPackages = [];
let searchQuery = "";
let abs_max = 0;
let max_price = 0;
let in_stock_only = false;
const loadPackagesFromAPI = async () => {
    try {
        const response = await fetch("/api.php", {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify({
                type: "Packages"
            })
        });
        const text = await response.text();
        console.log("RAW API RESPONSE:", text);
        const result = JSON.parse(text);

        if (result.status !== "success") {
            console.error("API Error:", result.message);
            cardsContainer.innerHTML = `<p class="not-found">Could not load packages.</p>`;
            return;
        }

        packages = result.data;

        renderPackages(packages, true);
 
    } catch (error) {
        console.error("Failed to fetch packages:", error);
        cardsContainer.innerHTML = `<p class="not-found">Something went wrong while loading packages.</p>`;
    }
};
const filterPackages = () => {
    filteredPackages = packages.filter((package) => (package.price <= max_price) &&(package.agency.toLowerCase().includes(searchQuery) || package.location.toLowerCase().includes(searchQuery) || package.title.toLowerCase().includes(searchQuery)));
    if (groupFilter !== soloFilter){
        if (groupFilter){
            filteredPackages = filteredPackages.filter((package) => package.package_type === "group");
        } else {
            filteredPackages = filteredPackages.filter((package) => package.package_type === "solo");
        }
    }
    if (in_stock_only){
        filteredPackages = filteredPackages.filter((package) => package.in_stock);
    }
    renderPackages(filteredPackages);
}

const cardsContainer = document.getElementById("packages-cards");
const maxPriceRange = document.getElementById("max-price");
const maxSelectedPrice = document.getElementById("max-selected-price");
const inStockOnly = document.getElementById("in-stock-only");
const searchBar = document.getElementById("search-bar");


searchBar.addEventListener("keyup", (e) => {
    searchQuery = e.target.value;
    filterPackages();
})

//Real-time search
let timeout = null;
searchBar.addEventListener('input', function() {
    clearTimeout(timeout);
    const query = this.value.trim();

    if (query.length < 2) {
        cardsContainer.innerHTML = '';
        return;
    }

    timeout = setTimeout(() => performSearch(query), 500); // Real-time with 500ms debounce
});

maxPriceRange.addEventListener("input", (e) => {
    maxSelectedPrice.innerHTML = `R${e.target.value}`;
    max_price = e.target.value;
});
maxPriceRange.addEventListener("change", () => {
    filterPackages();
});
inStockOnly.addEventListener("change", (e) => {
    if (e.target.checked) {
        in_stock_only = true;
    } else {
        in_stock_only = false;
    }
    filterPackages();
})



async function performSearch(query) {
    try {
        const res = await fetch('/api.php', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ type: "Search", query: query })
        });

        const data = await res.json();

        if (data.status === "success") {
            allPackages = data.data || [];
            renderPackages(allPackages, true);
            packages = allPackages;
            filteredPackages = allPackages;
            console.log(allPackages);
        }
    } catch (err) {
        console.error("Search error:", err);
    }
}  

performSearch("");
const renderPackages = (packagesArray, firstRender = false) => {
    cardsContainer.innerHTML = "";
    if (packagesArray.length === 0){
        cardsContainer.innerHTML = `<p class="not-found">No package found matching your search and/or filters.<p>`;
        return;
    }
    if (firstRender){
        max_price = Math.max(...packagesArray.map(p => p.price));
        maxPriceRange.max = max_price;
        maxPriceRange.value = max_price;
        maxSelectedPrice.innerText = `R${max_price.toLocaleString()}`;
    }

    packagesArray.forEach((package) => {
        const packageCard = document.createElement("div");
        const packageLink = document.createElement("a");
        packageLink.href = `package.php?package_id=${package.package_id}`
        packageCard.classList.add("package-card");
        packageCard.innerHTML = `
            <div class="card-img-container">
                <img src="/${package.image_url}" alt="${package.title}">  
                <div class="availability-rating">
                    <div class="availability ${package.in_stock ? "in-stock" : "out-of-stock"}">
                        <span class="dot">•</span>
                        <span>${package.in_stock ? "In stock" : "Sold out"}</span>
                    </div>
                    <div class="rating">
                        <svg width="15" height="15" viewBox="0 0 100 100">
                            <polygon points="50,5 61,35 95,35 67,57 78,90 50,72 22,90 33,57 5,35 39,35" fill="orange"/>
                        </svg> 
                        <span>${package.rating}</span>
                    </div>
                </div>
            </div>
            <div class="card-text">
                <p class="agency-name">${package.agency}</p>
                <div class="location">
                    <img src="../img/icons/map-pin-blue.svg" alt="Map pin">
                    <p>${package.location}</p>
                </div>
                <p class="package-title">${package.title}</p>
                <div class="package-labels">
                    <div class="${package.package_type === "solo" ? "solo-package" : "group-package"}">
                        <img src="${package.package_type === "solo" ? "../img/icons/user-orange.svg" : "../img/icons/users.svg"}" alt="Package type">
                        <span>${package.package_type === "solo" ? "Solo Package" : "Group Package"}</span>
                    </div>
                    <div class="nights">
                        <img src="../img/icons/clock.svg" alt="Clock">
                        <span>${package.activities.length} nights</span>
                    </div>
                </div>
                <div class="hr"></div>
                <div>
                    <p class="package-from">FROM</p>
                    <div class="package-price">
                        <p><span>R${package.price.toLocaleString()}</span>/pp</p>
                    </div>
                </div>
            </div>
        `;
        packageLink.appendChild(packageCard);
        cardsContainer.appendChild(packageLink);

    })
}