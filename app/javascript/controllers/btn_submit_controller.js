import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
static targets = ["image"]
static values = {sound: String}


  animation() {
    this.imageTarget.classList.add("constant-tilt-shake-on-click");
    const audio = new Audio(this.soundValue);
    audio.play();




  }



}
