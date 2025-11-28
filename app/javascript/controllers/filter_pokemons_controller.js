import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="filter-pokemons"
export default class extends Controller {
  connect() {
    console.log("Hello from our first Stimulus controller");
  }

  static targets = ["form", "all", "other"]

  filter(event) {
  event.preventDefault();
  this.formTarget.requestSubmit();
  this.allTarget.classList.add("active");

  this.otherTargets.forEach(other => {
    other.classList.remove("active");
  });
}
}
