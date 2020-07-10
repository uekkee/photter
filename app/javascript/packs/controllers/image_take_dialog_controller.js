import { Controller } from 'stimulus'
import Rails from "@rails/ujs"

export default class ImageTakeDialogController extends Controller {
  static targets = ['imageListParent', 'imageColumnTemplate', 'tagInput', 'tagListParent', 'tagTemplate', 'tagElement', 'submitButton']

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

  async submit() {
    this.submitButtonTarget.classList.add('is-loading')

    const body = new FormData()
    this.imageUrls.forEach((imageUrl) => body.append('bulk_register[image_urls][]', imageUrl))
    this.tags.forEach((tag) => body.append('bulk_register[tag_names][]', tag))

    const response = await fetch('/bulk_register_image', {
      method: 'POST',
      credentials: 'same-origin',
      headers: {
        Accept: 'application/json',
        'X-CSRF-Token': Rails.csrfToken(),
      },
      body: body,
    })

    if(!response.ok) throw new Error()

    this.close()
    this.submitButtonTarget.classList.remove('is-loading')
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
