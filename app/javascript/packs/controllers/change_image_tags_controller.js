import { Controller } from 'stimulus'

export default class ChangeImageTagsController extends Controller {
  static targets = ['tag']

  connect() {
    this._imageUrl = this.data.get('imageUrl')
  }

  showTakeDialog() {
    this.imageTakeDialogController.pushImageUrls([this._imageUrl])
    this.tagTargets.forEach((tag) => this.imageTakeDialogController.pushTag(tag.value))
    this.imageTakeDialogController.applySuccessCallback(() => window.location.reload())
    this.imageTakeDialogController.show()
  }

  get imageTakeDialogController() {
    const dialogElement = document.getElementById('take-dialog')
    return this.application.getControllerForElementAndIdentifier(dialogElement, 'image-take-dialog')
  }
}
