import { Controller } from 'stimulus'

export default class ImageColumnController extends Controller {
  static targets = ['thumbnailImgTag', 'checkedTag']

  connect() {
    this._checked = false
    this._imageUrl = this.data.get('imageUrl')
    this._thumbnailUrl = this.data.get('thumbnailUrl')
    this.build()
  }

  get checked() {
    return this._checked
  }

  get thumbnailUrl() {
    return this._thumbnailUrl
  }

  get imageUrl() {
    return this._imageUrl
  }

  click() {
    this._checked = !this.checked
    if (this.checked) this.checkedTagTarget.classList.remove('is-hidden')
    else this.checkedTagTarget.classList.add('is-hidden')
  }

  build() {
    if (this._thumbnailUrl) {
      this.thumbnailImgTagTarget.dataset.src = this._thumbnailUrl
      this.element.classList.remove('is-hidden')
    }
  }
}
