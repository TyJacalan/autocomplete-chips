class CustomFormBuilder < ActionView::Helpers::FormBuilder
  def autocomplete_chip(attribute, url:, placeholder: "Type something...", selected_items: [])
    @template.content_tag :div, data: { controller: "autocomplete-chip", autocomplete_chip_url_value: url }, class: "w-full space-y-2" do
      @template.concat label(attribute)
      @template.concat @template.content_tag(:div, "", id: "autocomplete-chip-chips", data: { autocomplete_chip_target: "chips" } )
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
end
