import { Application } from "@hotwired/stimulus"
import Stimulus_reflex from "stimulus_reflex";

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

Stimulus_reflex.initialize(application, { isolate: true })

export { application }
