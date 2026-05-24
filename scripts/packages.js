const packagesUsername = document.getElementById("packages-username");

const storedUser = JSON.parse(localStorage.getItem("user") || "{}");

if (packagesUsername) {
    packagesUsername.textContent = storedUser.username || storedUser.name || "Traveller";
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
        const response = await fetch("api.php", {
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
    if (in_stock_only)
    {
        filteredPackages = filteredPackages.filter((package) => package.in_stock === "In stock");
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

maxPriceRange.addEventListener("input", (e) => {
    maxSelectedPrice.innerHTML = `R${e.target.value}`;
    max_price = e.target.value;
});
maxPriceRange.addEventListener("change", () => {
    filterPackages();
});
inStockOnly.addEventListener("change", (e) => {
    in_stock_only = e.target.checked;
    filterPackages();
});

const renderPackages = (packagesArray, firstRender = false) => {
    cardsContainer.innerHTML = "";

    if (packagesArray.length === 0){
        cardsContainer.innerHTML = `<p class="not-found">No package found matching your search and/or filters.</p>`;
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

        packageLink.href = `package.php?package_id=${package.package_id}`;
        packageCard.classList.add("package-card");

        packageCard.innerHTML = `
            <div class="card-img-container">
                <img src="${package.image_url}" alt="${package.title}">  
                <div class="availability-rating">
                    <div class="availability ${package.in_stock === "In stock" ? "in-stock" : "out-of-stock"}">
                        <span class="dot">•</span>
                        <span>${package.in_stock}</span>
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
                        <span>${package.description}</span>
                    </div>
                </div>

                <div class="hr"></div>

                <div>
                    <p class="package-from">FROM</p>
                    <div class="package-price">
                        <p><span>R${package.price.toLocaleString()}</span>/pp</p>
                        <button id="explore-btn">Explore</button>
                    </div>
                </div>
            </div>
        `;

        packageLink.appendChild(packageCard);
        cardsContainer.appendChild(packageLink);
    });
};
loadPackagesFromAPI();