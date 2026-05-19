let slideIndex = 0;

function showSlides() {
  const slides = document.getElementsByClassName("slide");

  // Remove old classes
  for (let i = 0; i < slides.length; i++) {
    slides[i].classList.remove("active", "previous");
  }

  let prevIndex = slideIndex;
  slideIndex = (slideIndex + 1) % slides.length;

  // Apply new classes
  slides[prevIndex].classList.add("previous");
  slides[slideIndex].classList.add("active");

  setTimeout(showSlides, 5000); // Slide every 5 seconds
}

document.addEventListener("DOMContentLoaded", () => {
  document.getElementsByClassName("slide")[0].classList.add("active");
  showSlides();
});
