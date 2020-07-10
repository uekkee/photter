import Rails from '@rails/ujs'

export default class ImagesRegister {
  constructor(imageUrls, tagNames) {
    this._imageUrls = imageUrls
    this._tagNames = tagNames
  }

  register() {
    const body = new FormData()
    this._imageUrls.forEach((imageUrl) => body.append('bulk_register[image_urls][]', imageUrl))
    this._tagNames.forEach((tag) => body.append('bulk_register[tag_names][]', tag))

    return fetch('/bulk_register_image', {
      method: 'POST',
      credentials: 'same-origin',
      headers: {
        'X-CSRF-Token': Rails.csrfToken(),
      },
      body,
    })
      .then((response) => {
        if (response.ok) return response.text()
        throw new Error('API Error!')
      })
  }
}

