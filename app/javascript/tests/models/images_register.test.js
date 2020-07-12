import ImagesRegister from 'packs/models/images_register'

describe('ImagesRegister', ()=> {
  describe('#register', ()=> {
    const imageUrls = ['https://localhost.localdomain/dog.jpg']
    const tagNames = ['dog', 'puppy']
    const imagesRegister = new ImagesRegister(imageUrls, tagNames)

    it('fetch success', ()=>{
      fetch.mockResponse('', { status: 204 })
      imagesRegister.register()
        .then((response) => {
          expect(response).toBe('')
        })
    })

    it('fetch error', ()=>{
      fetch.mockResponse('', { status: 422 })
      imagesRegister.register()
        .catch((error) => {
          expect(error.message).toBe('API Error!')
        })
    })
  })
})
