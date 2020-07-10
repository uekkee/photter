import { Controller } from 'stimulus'

export default class ImageListController extends Controller {
  static targets = ['listParent', 'imageColumnTemplate', 'imageColumn', 'takeModal', 'takeModalNav']

  connect() {
    this.prosessing = false
    this.fetchImages()
  }

  async fetchImages() {
    if (this.prosessing) return

    this.prosessing = true

    const response = await fetch('/api/images?q=dog', {
      method: 'GET',
      credentials: 'same-origin',
      headers: {
        Accept: 'application/json',
      },
    })

    if (!response.ok) throw new Error()

    const json = await response.json()

    json.forEach((record) => this.buildImageColumn(record.image_url, record.thumbnail_url))

    this.prosessing = false
  }

  showOrHideTakeModalNav() {
    if (this.checkedImageUrls.length > 0) {
      this.takeModalNavTarget.classList.remove('is-hidden')
    } else {
      this.takeModalNavTarget.classList.add('is-hidden')
    }
  }

  showTakeDialog() {
    this.imageTakeDialogController.pushImageUrls(this.checkedImageUrls)
    this.imageTakeDialogController.show()
  }

  fetchIfScrollAlmostEnd() {
    const scrollablePixels = document.body.offsetHeight - window.scrollY - window.innerHeight
    if (scrollablePixels < 300) this.fetchImages()
  }

  get checkedImageUrls() {
    return this
      .imageColumnTargets
      .map((element) => this.imageColumnController(element))
      .filter((controller) => controller.checked)
      .map((controller) => controller.imageUrl)
  }

  imageColumnController(element) {
    return this.application.getControllerForElementAndIdentifier(element, 'image-column')
  }

  get imageTakeDialogController() {
    return this.application.getControllerForElementAndIdentifier(this.takeModalTarget, 'image-take-dialog')
  }

  buildImageColumn(imageUrl, thumbnailUrl) {
    const template = this.imageColumnTemplateTarget.cloneNode(true)
    template.dataset.target = 'image-list.imageColumn'
    template.dataset.imageColumnImageUrl = imageUrl
    template.dataset.imageColumnThumbnailUrl = thumbnailUrl
    this.listParentTarget.appendChild(template)
  }
}
