import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["list"]

    refresh() {
        fetch("/jobs/refresh")
            .then(response => response.json())
            .then(data => {
                this.listTarget.innerHTML = ""
                console.log(1)
                // Add jobs dynamically
                data.forEach(job => {
                    const li = document.createElement("li")
                    li.innerHTML = `<strong>${job.title}</strong> at ${job.company}<br>${job.description} <a href="${job.link}" target="_blank">Link</a>`
                    this.listTarget.appendChild(li)
                })
            })
    }
}

