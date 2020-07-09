import { Controller } from 'stimulus'

export default class ImageTakeDialogController extends Controller {
  static targets = ['imageListParent', 'imageColumnTemplate', 'tagInput', 'tagListParent', 'tagTemplate', 'tagElement']

  pushImageUrls(imageUrls) {
    this.imageUrls = imageUrls
    imageUrls.forEach((imageUrl) => this.buildImage(imageUrl))
  }

  enterTag() {
    const tagName = this.tagInputTarget.value
    if (tagName) {
      this.buildTag(tagName)
      this.tagInputTarget.value = ''
    }
  }

  close() {
    this.element.classList.remove('is-active')
    this.imageListParentTarget.textContent = ''
  }

  get tags() {
    return this
      .tagElementTargets
      .map((element) => this.imageTagController(element))
      .filter((controller) => controller.active)
      .map((controller) => controller.name)
  }

  imageTagController(element) {
    return this.application.getControllerForElementAndIdentifier(element, 'image-tag')
  }

  buildImage(imageUrl) {
    const template = this.imageColumnTemplateTarget.cloneNode(true)
    template.getElementsByClassName('js-image')[0].src = imageUrl
    template.classList.remove('is-hidden')
    delete template.dataset.target
    this.imageListParentTarget.appendChild(template)
  }

  buildTag(tagName) {
    const template = this.tagTemplateTarget.cloneNode(true)
    template.dataset.imageTagName = tagName
    template.dataset.target = 'image-take-dialog.tagElement'
    this.tagListParentTarget.appendChild(template)
  }
}
