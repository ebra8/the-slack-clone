import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.scrollToBottom()
    this.setupObserver()
  }

  scrollToBottom() {
    requestAnimationFrame(() => {
      this.element.scrollTop = this.element.scrollHeight
    })
  }

  setupObserver() {
    this.observer = new MutationObserver(() => {
      this.scrollToBottom()
    })
    this.observer.observe(this.element, {
      childList: true,
      subtree: true,
      characterData: true
    })
  }

  disconnect() {
    if (this.observer) {
      this.observer.disconnect()
    }
  }
}
