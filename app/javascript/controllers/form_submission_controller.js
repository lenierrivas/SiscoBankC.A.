import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    // Funcion para el search index con turbo
    search() {
        clearTimeout(this.timeout)
        this.timeout = setTimeout(() => {
            this.element.requestSubmit()
        }, 200)
    }
}