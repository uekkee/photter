import ImagesFetcher from 'packs/models/images_fetcher'

describe('ImagesFetcher', () => {
  describe('#fetchNext and #hasNext', () => {
    const query = 'dog'
    let imagesFetcher
    const imagesJson = [
      {
        thumbnail_url: 'https://localhost.localdomain/dog_thumb.jpg',
        image_url: 'https://localhost.localdomain/dog.jpg',
      },
    ]
    const oneTotalPageJson = {
      total_pages: 1,
      images: imagesJson,
    }
    const twoTotalPagesJson = {
      total_pages: 2,
      images: imagesJson,
    }

    beforeEach(() => {
      imagesFetcher = new ImagesFetcher(query)
    })

    it('defaultHasNext is true', () => {
      expect(imagesFetcher.hasNext).toBe(true)
    })

    it('fetch success with one total page', () => {
      fetch.mockResponse(JSON.stringify(oneTotalPageJson), { status: 200 })
      imagesFetcher.fetchNext()
        .then((json) => {
          expect(json).toStrictEqual(imagesJson)
          expect(imagesFetcher.hasNext).toBe(false)
        })
    })

    it('fetch success with two total pages', () => {
      fetch.mockResponse(JSON.stringify(twoTotalPagesJson), { status: 200 })
      imagesFetcher.fetchNext()
        .then((json) => {
          expect(json).toStrictEqual(imagesJson)
          expect(imagesFetcher.hasNext).toBe(true)
        })
    })

    it('fetch error', () => {
      fetch.mockResponse('', { status: 422 })
      imagesFetcher.fetchNext()
        .catch((error) => {
          expect(error.message).toBe('API Error!')
        })
    })
  })
})
