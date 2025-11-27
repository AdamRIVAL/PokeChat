import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
static targets = ["image"]

  animation() {
  this.imageTarget.classList.add("constant-tilt-shake-on-click");
  }

  // sound() {
  // }
}
