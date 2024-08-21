# Autocomplete Chip Input Component for Rails

### Overview
The Autocomplete Chip Input component is a reusable and customizable form input field designed for Ruby on Rails applications. It enables users to search, select, and visually manage multiple items with autocomplete suggestions, all presented in a user-friendly chip format.

This component is built using Rails' FormBuilder, making it easy to integrate into any form in your Rails application. It leverages StimulusJS for dynamic frontend behavior and Tailwind CSS for modern, responsive styling.

### Features
**Dynamic Autocomplete:** As users type, the component fetches and displays autocomplete suggestions from a configurable endpoint.
**Chip-Based Selection:** Selected items are displayed as chips, providing a clean and intuitive UI for managing multiple selections.
**Configurable:** Easily customize the search endpoint, placeholder text, and pre-selected items directly from the view.
**Reusable:** Implemented as a Rails FormBuilder method, the component can be reused across different forms and models with minimal configuration.

### Usage
1. Add the `autocomplete chip` component into your custom form builder or create one if you don't have one already.
```ruby
  def autocomplete_chip(attribute, url:, placeholder: "Type something...", selected_items: [])
    @template.content_tag :div, data: { controller: "autocomplete-chip", autocomplete_chip_url_value: url }, class: "w-full" do
      @template.concat label(attribute)
      @template.concat(
        text_field(
          attribute,
          class: "h-10 w-full px-2 rounded-md shadow-md text-gray-800",
          data: { action: "input->autocomplete-chip#search", autocomplete_chip_target: "input" },
          autocomplete: "off",
          placeholder: placeholder
        )
      )
      @template.concat @template.content_tag(:div, "", id: "autocomplete-chip-results", class: "hidden bg-white text-black rounded-md shadow-md mt-1 p-2", data: { autocomplete_chip_target: "results" })
      @template.concat hidden_field("#{attribute}_names", value: selected_items.join(','), data: { autocomplete_chip_target: "hidden" })
    end
  end
```

2. Create the autocomplete-chip Stimulus controller
```bash
bin/rails g stimulus autocomplete-chip
```
Then add the following lines of code:
```javascript
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["input", "results", "hidden"];
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
      "chip",
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

    this.inputTarget.insertAdjacentElement("beforebegin", chip);

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

```

3. Use the autocomplete_chip component inside of a form
```erb
Copy code
<%= form_with url: assign_pets_path, method: :post do |f| %>
  <%= f.autocomplete_chip :animals, url: searches_animals_path, placeholder: "Start typing to search for animals..." %>

  <%= f.submit "Submit" %>
<% end %>
```

### Parameters
**attribute:** The name of the attribute for which the autocomplete is being implemented.
**url: **The URL endpoint to fetch autocomplete suggestions.
**placeholder (optional):** Placeholder text for the input field.
**selected_items (optional):** An array of items to pre-populate the hidden field (useful for editing forms).

### Customization
This component is designed to be easily extendable. You can customize or extend it further by modifying the Stimulus controller, adjusting the Tailwind CSS classes, or adding additional functionality within the CustomFormBuilder.

## License
Licensed under the [MIT license](https://github.com/TyJacalan/autocomplete-chips/blob/main/LICENSE).
