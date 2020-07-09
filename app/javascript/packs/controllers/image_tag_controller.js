import { Controller } from 'stimulus'

export default class ImageTagController extends Controller {
  static targets = ['tagTextContent']

  connect() {
    this._active = false
    this._name = this.data.get('name')
    this.build()
  }

  get active() {
    return this._active
  }

  get name() {
    return this._name
  }

  build() {
    if (this.name) {
      this._active = true
      this.tagTextContentTarget.textContent += this.name
      this.element.classList.remove('is-hidden')
    }
  }

  delete() {
    this._active = false
    this.element.classList.add('is-hidden')
  }
}
