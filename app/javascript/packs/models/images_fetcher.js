export default class ImagesFetcher {
  constructor(query) {
    this._query = query
    this._nextPage = 1
    this._totalPages = 1
  }

  get query() {
    return this._query
  }

  get hasNext() {
    return this._nextPage <= this._totalPages
  }

  fetchNext() {
    const searchParams = new URLSearchParams()
    searchParams.set('q', this.query)
    searchParams.set('page', this._nextPage)

    return fetch(`/api/images?${searchParams.toString()}`, {
      method: 'GET',
      credentials: 'same-origin',
      headers: {
        Accept: 'application/json',
      },
    })
      .then((response) => {
        if (response.ok) return response.json()
        throw new Error('API Error!')
      })
      .then((json) => {
        this._nextPage += 1
        this._totalPages = json.total_pages
        return json.images
      })
  }
}
