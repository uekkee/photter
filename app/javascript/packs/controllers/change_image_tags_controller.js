import { Controller } from 'stimulus'

export default class ChangeImageTagsController extends Controller {
  static targets =
    [
      'tag'
    ]

  connect() {
    this._imageUrl = this.data.get('imageUrl')
  }

  showTakeDialog() {
    const imageTakeDialogController = this.imageTakeDialogController

    imageTakeDialogController.pushImageUrls([this._imageUrl])
    this.tagTargets.forEach((tag) => imageTakeDialogController.pushTag(tag.value))
    imageTakeDialogController.applySuccessCallback(() => location.reload())
    imageTakeDialogController.show()
  }

  get imageTakeDialogController() {
    const modalElement = document.getElementById('take-modal')
    return this.application.getControllerForElementAndIdentifier(modalElement, 'image-take-dialog')
  }
}
