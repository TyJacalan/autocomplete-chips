import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["input", "chips", "results", "hidden"];
  static values = { url: String };

  connect() {
    this.selectedAnimals = [];
  }

  search() {
    const query = this.inputTarget.value;
    if (query.length < 2) return;
    fetch(`${this.urlValue}?query=${encodeURIComponent(query)}`)
      .then((response) => response.json())
      .then((data) => {
        if (data.length > 0) {
          this.showResults(data);
        } else {
          this.hideResults();
        }
      });
  }

  showResults(animals) {
    this.resultsTarget.innerHTML = "";
    this.resultsTarget.classList.remove("hidden");
    animals.forEach((animal) => {
      const item = document.createElement("div");
      item.textContent = animal;
      item.classList.add(
        "cursor-pointer",
        "p-2",
        "rounded-md",
        "hover:bg-gray-200",
        "transition-colors",
      );
      item.addEventListener("click", () => this.addChip(animal));
      this.resultsTarget.appendChild(item);
    });
  }

  hideResults() {
    this.resultsTarget.classList.add("hidden");
  }

  addChip(animal) {
    if (this.selectedAnimals.includes(animal)) return; // Avoid duplicates

    this.selectedAnimals.push(animal);

    const chip = document.createElement("span");
    chip.textContent = animal;
    chip.classList.add(
      "w-fit",
      "bg-teal-600",
      "text-white",
      "rounded-full",
      "px-3",
      "py-1",
      "mx-1",
      "my-2",
      "inline-block",
      "hover:bg-red-600",
      "hover:cursor-pointer",
    );
    chip.addEventListener("click", () => this.removeChip(animal, chip));

    this.chipsTarget.appendChild(chip);

    this.updateHiddenField();
    this.inputTarget.value = "";
    this.resultsTarget.innerHTML = ""; // Clear autocomplete suggestions
    this.hideResults();
  }

  removeChip(animal, chip) {
    this.selectedAnimals = this.selectedAnimals.filter((a) => a !== animal);
    chip.remove();
    this.updateHiddenField();
  }

  updateHiddenField() {
    this.hiddenTarget.value = this.selectedAnimals.join(",");
  }
}
