// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

// funcion para redirect a elemento seleccionado a consultar en el index
	document.addEventListener("turbo:frame-missing", async (event) => {
		event.preventDefault()
		window.location.replace( event.detail.response.url );
	})