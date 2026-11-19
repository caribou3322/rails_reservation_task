import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["menu"]

  connect() {
    console.log("dropdown connected")
    this.menuTarget.hidden = true
    this.handleOutsideClick = this.handleOutsideClick.bind(this)
    this.handleBeforeCache = this.handleBeforeCache.bind(this)

    document.addEventListener("click", this.handleOutsideClick)
    document.addEventListener("turbo:before-cache", this.handleBeforeCache)
  }

  disconnect() {
    document.removeEventListener("click", this.handleOutsideClick)
    document.removeEventListener("turbo:before-cache", this.handleBeforeCache)
  }

  toggle(event) {
    event.preventDefault()
    event.stopPropagation()
    this.menuTarget.hidden = !this.menuTarget.hidden
  }

  handleOutsideClick(event) {
    if (!this.element.contains(event.target)) {
      this.menuTarget.hidden = true
    }
  }

  handleBeforeCache() {
    this.menuTarget.hidden = true
  }
}