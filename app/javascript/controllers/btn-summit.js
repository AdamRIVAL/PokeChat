import { Controller } from '@hotwired/stimulus'

export default class extends Controller {

  connect() {
    const btn = document.getElementById("btn-summit")
    const img = document.getElementById("constant-tilt-shake")

    btn.addEventListener("click", (event) => {
      event.preventDefault();
      console.log("test");
      // à finir
    });
  }
}
