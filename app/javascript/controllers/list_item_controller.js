import { Controller } from "@hotwired/stimulus"
import Sortable from 'sortablejs'

export default class extends Controller {

  connect() {
    this.sortable = Sortable.create(this.element, {
      animation: 150,
      fallbackOnBody: true,
      swapThreshold: 0.65,
      onEnd: this.end.bind(this)
    })
  }

  end(event) {
    // console.log(event)

    let item = event.item.dataset.id
    let todo_id = event.item.dataset.todoId
    let data = new FormData()

    data.append("position", event.newIndex + 1)
    data.append("item_id", item)

    let url = this.data.get('url').replace(":id", todo_id)

    window.mrujs.fetch(url, {
      method: 'PATCH',
      body: data
    }).then(() => {}).catch((error) => console.error(error))

  }

}
