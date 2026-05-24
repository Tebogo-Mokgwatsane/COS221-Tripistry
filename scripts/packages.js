const packagesUsername = document.getElementById("packages-username");
packagesUsername.textContent = user.name;

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
let packages = [
  {
    package_id: 1,
    image_url: "https://images.unsplash.com/photo-1507525428034-b723cf961d3e",
    in_stock: true,
    rating: 4.9,
    agency: "CAPE TOWN TOURS",
    location: "Cape Town, South Africa",
    title: "Table Mountain Adventure",
    package_type: "group",
    nights: "5 nights",
    price: 6125
  },
  {
    package_id: 2,
    image_url: "https://images.unsplash.com/photo-1516026672322-bc52d61a55d5",
    in_stock: false,
    rating: 4.7,
    agency: "WILD ESCAPES",
    location: "Kruger National Park, South Africa",
    title: "Big Five Safari Experience",
    package_type: "group",
    nights: "3 nights",
    price: 9850
  },
  {
    package_id: 3,
    image_url: "https://images.unsplash.com/photo-1506744038136-46273834b3fb",
    in_stock: true,
    rating: 4.8,
    agency: "OCEANIC GETAWAYS",
    location: "Durban, South Africa",
    title: "Beachfront Relaxation Tour",
    package_type: "solo",
    nights: "7 nights",
    price: 4999
  },
  {
    package_id: 4,
    image_url: "https://images.unsplash.com/photo-1493246507139-91e8fad9978e",
    in_stock: true,
    rating: 5.0,
    agency: "JOZI TRAVEL CO.",
    location: "Johannesburg, South Africa",
    title: "City Lights Weekend",
    package_type: "group",
    nights: "2 nights",
    price: 2450
  },
  {
    package_id: 5,
    image_url: "https://images.unsplash.com/photo-1521295121783-8a321d551ad2",
    in_stock: true,
    rating: 4.6,
    agency: "MOUNTAIN TRAILS",
    location: "Drakensberg, South Africa",
    title: "Hiking & Camping Escape",
    package_type: "solo",
    nights: "4 nights",
    price:5300
  },
  {
    package_id: 6,
    image_url: "https://images.unsplash.com/photo-1470770841072-f978cf4d019e",
    in_stock: true,
    rating: 4.9,
    agency: "SUNSET VOYAGES",
    location: "Garden Route, South Africa",
    title: "Garden Route Discovery",
    package_type: "group",
    nights: "6 nights",
    price: 8700
  },
  {
    package_id: 7,
    image_url: "https://images.unsplash.com/photo-1500530855697-b586d89ba3ee",
    in_stock: true,
    rating: 4.5,
    agency: "CITYSCAPE TOURS",
    location: "Pretoria, South Africa",
    title: "Historical Landmarks Tour",
    package_type: "solo",
    nights: "1 night",
    price: 1799
  },
  {
    package_id: 8,
    image_url: "https://images.unsplash.com/photo-1469474968028-56623f02e42e",
    in_stock: false,
    rating: 4.8,
    agency: "BY AFRICAN SUN TRAVEL",
    location: "Limpopo, South Africa",
    title: "Luxury Bush Retreat",
    package_type: "group",
    nights: "8 nights",
    price: 12400
  }
];



let filteredPackages = [];
let searchQuery = "";
let abs_max = 0;
let max_price = 0;
let in_stock_only = false;

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
                <img src="${package.image_url}" alt="${package.title}">  
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
                        <span>${package.nights}</span>
                    </div>
                </div>
                <div class="hr"></div>
                <div>
                    <p class="package-from">FROM</p>
                    <div class="package-price">
                        <p><span>R${package.price.toLocaleString()}</span>/pp</p>
                        <button id="explore-btn">Explore </button>
                    </div>
                </div>
            </div>
        `;
        packageLink.appendChild(packageCard);
        cardsContainer.appendChild(packageLink);

    })
}

renderPackages(packages, true);