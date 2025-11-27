import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="filter-pokemons"
export default class extends Controller {
  connect() {
    console.log("Hello from our first Stimulus controller");
  }

  static targets = ["form"]

  filter(event) {
    event.preventDefault()
    this.formTarget.requestSubmit();
  }
}
