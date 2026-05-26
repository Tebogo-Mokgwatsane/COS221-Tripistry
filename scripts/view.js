const params = new URLSearchParams(window.location.search);
const id = params.get("package_id");

const getPackageInfo = async () => {
    try {
        const res = await fetch('../api.php', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json'},
            body: JSON.stringify({
                type: "GetPackage",
                package_id: id
            })
        });

        const data = await res.json();
        console.log(data);
        
    } catch (err) {
        console.log(err)
    }
}

getPackageInfo();

const activities = [
    {
        day: 1,
        title: "Cape Town Arrival",
        activities: [
          {
            time: "14:00",
            activity: "Airport welcome",
            description: "Meet the group and transfer to the hotel."
          },
          {
            time: "17:00",
            activity: "Camps Bay sunset",
            description: "Relax by the beach and enjoy ocean views."
          }
        ]

    },

    {
        day: 2,
        title: "Table Mountain Adventure",
        activities: [
        {
            time: "08:00",
            activity: "Table Mountain cableway",
            description: "Ride to the summit for panoramic city views."
        },
        {
            time: "10:30",
            activity: "Guided mountain walk",
            description: "Explore scenic trails and viewpoints."
        },
        {
            time: "13:00",
            activity: "Picnic at the top",
            description: "Enjoy lunch overlooking Cape Town."
        },
        {
            time: "18:30",
            activity: "Dinner at the V&A Waterfront",
            description: "Enjoy local seafood and live music."
        }
        ]
    },

    {
        day: 3,
        title: "Cape Peninsula Tour",
        activities: [
        {
            time: "07:30",
            activity: "Chapman’s Peak drive",
            description: "Travel along one of the world’s most scenic roads."
        },
        {
            time: "10:00",
            activity: "Cape Point visit",
            description: "Explore the dramatic cliffs and lighthouse."
        },
        {
            time: "13:00",
            activity: "Boulders Beach penguins",
            description: "See the famous African penguin colony."
        },
        {
            time: "17:00",
            activity: "Fish and chips by the harbour",
            description: "Enjoy fresh seafood in Simon’s Town."
        }
        ]
    },

    {
        day: 4,
        title: "Wine Tram Experience",
        activities: [
        {
            time: "09:00",
            activity: "Travel to Franschhoek",
            description: "Journey into the Cape Winelands."
        },
        {
            time: "11:00",
            activity: "Wine tram tour",
            description: "Visit multiple wine estates by tram."
        },
        {
            time: "13:30",
            activity: "Wine tasting lunch",
            description: "Pair local wines with gourmet dishes."
        },
        {
            time: "18:00",
            activity: "Return to Cape Town",
            description: "Relax after a full day in the vineyards."
        }
        ]
    },

    {
        day: 5,
        title: "Adventure Day",
        activities: [
        {
            time: "08:00",
            activity: "Paragliding from Signal Hill",
            description: "Soar above the coastline and city skyline."
        },
        {
            time: "12:00",
            activity: "Bo-Kaap exploration",
            description: "Visit the colourful streets and local cafés."
        },
        {
            time: "16:00",
            activity: "Sunset catamaran cruise",
            description: "Cruise along the Atlantic coastline."
        }
        ]
    },

    {
        day: 6,
        title: "Safari Experience",
        activities: [
        {
            time: "05:30",
            activity: "Early safari departure",
            description: "Travel to a nearby private game reserve."
        },
        {
            time: "09:00",
            activity: "Morning game drive",
            description: "Spot lions, elephants, rhinos, and giraffes."
        },
        {
            time: "13:00",
            activity: "Bush lunch",
            description: "Enjoy lunch surrounded by nature."
        },
        {
            time: "16:00",
            activity: "Second game drive",
            description: "Look for wildlife during golden hour."
        }
        ]
    },

    {
        day: 7,
        title: "Culture & Food",
        activities: [
        {
            time: "09:00",
            activity: "District Six Museum",
            description: "Learn about Cape Town’s history and culture."
        },
        {
            time: "12:00",
            activity: "Cape Malay cooking class",
            description: "Cook traditional South African dishes."
        },
        {
            time: "18:30",
            activity: "Braai night",
            description: "Enjoy a classic South African barbecue experience."
        }
        ]
    },

    {
        day: 8,
        title: "Relax & Departure",
        activities: [
        {
            time: "08:00",
            activity: "Sea Point promenade walk",
            description: "Enjoy a peaceful morning by the ocean."
        },
        {
            time: "11:00",
            activity: "Last-minute shopping",
            description: "Browse local crafts and souvenirs."
        },
        {
            time: "15:00",
            activity: "Airport transfer",
            description: "Depart Cape Town with unforgettable memories."
        }
        ]
    }
];

const timeline = document.getElementById("timeline");

activities.forEach((day) => {
    const card = document.createElement("div");
    card.className = "day-card";
    const activitiesCard = day.activities.map((item) => `
        <div class="day-activity">
          <div class="activity-time">${item.time}</div>
          <div class="divider"></div>

          <div class="activity-content">
            <h2>${item.activity}</h2>
            <p>${item.description}</p>
          </div>
        </div>
      `).join("");

      card.innerHTML = `
        <div class="day-number">${day.day}</div>

        <div class="day-label">Day ${day.day}</div>
        <h2 class="day-title">${day.title}</h2>

        <div class="activities-count">
          ${day.activities.length} activities
        </div>

        ${activitiesCard}
      `;

      timeline.appendChild(card);
    });