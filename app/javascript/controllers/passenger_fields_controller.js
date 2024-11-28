import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="passenger-fields"
export default class extends Controller {
  static targets = ["list", "addButton", "removeButton", "template"];

  get passengerCount() {
    return this.listTarget.querySelectorAll("li").length;
  }

  get isAtMinPassengers() {
    return this.passengerCount <= 1;
  }

  get isAtMaxPassengers() {
    return this.passengerCount >= 4;
  }

  connect() {
    this.displayButtons();
  }

  displayButtons() {
    this.removeButtonTargets.forEach((button) => {
      button.hidden = this.isAtMinPassengers;
    });

    this.addButtonTarget.hidden = this.isAtMaxPassengers;
  }

  addPassenger(event) {
    event.preventDefault();

    if (this.isAtMaxPassengers) {
      return;
    }

    const templateContent = this.templateTarget.content.cloneNode(true);

    const newIndex = this.passengerCount;

    templateContent.querySelectorAll("[name]").forEach((element) => {
      element.name = element.name.replace(/\[\d+\]/, `[${newIndex}]`);
    });
    templateContent.querySelectorAll("[id]").forEach((element) => {
      element.id = element.id.replace(/_\d+_/, `_${newIndex}_`);
    });

    this.listTarget.appendChild(templateContent);

    this.displayButtons();
  }

  removePassenger(event) {
    event.preventDefault();

    if (this.isAtMinPassengers) {
      return;
    }

    event.target.closest("li").remove();

    this.displayButtons();
  }
}
