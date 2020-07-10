import { Controller } from 'stimulus'
import ImagesFetcher from '../models/images_fetcher'

export default class ImageListController extends Controller {
  static targets =
    [
      'queryInput',
      'listParent', 'imageColumnTemplate', 'imageColumn',
      'takeModal', 'takeModalNav',
      'apiErrorNotification',
    ]

  queryInput() {
    this.apiErrorNotificationTarget.classList.add('is-hidden')
    const query = this.queryInputTarget.value
    if (!query) return

    this.listParentTarget.textContent = ''
    this.prosessing = false
    this._imageFetcher = new ImagesFetcher(query)
    this.fetchNextImages()
  }

  fetchNextImages() {
    if (this.prosessing || !this._imageFetcher || !this._imageFetcher.hasNext) return

    this.prosessing = true

    this._imageFetcher.fetchNext()
      .then((images) => {
        images.forEach((record) => this.buildImageColumn(record.image_url, record.thumbnail_url))
      })
      .catch(() => {
        this.apiErrorNotificationTarget.classList.remove('is-hidden')
      })
      .finally(() => {
        this.prosessing = false
      })
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
    if (scrollablePixels < 300) this.fetchNextImages()
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
