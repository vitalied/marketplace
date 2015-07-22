module AdminHelper

  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = "sort-link"
    css_class << " sort-current sort-#{sort_direction}" if column == sort_column
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"

    link_to title, params.merge(sort: column, dir: direction, page: nil), class: css_class, remote: true
  end

  def can_add_resource?(object = model)
    can? :create, object
  end

  def in_place_edit(object, attr, opts = {})
    opts = { class: "best-in-place", inner_class: "form-control input-sm inline-block", place_holder: "-none-" }.merge(opts)
    best_in_place_if can?(:update, object), object, attr, opts
  end

  def object_to_param(object = nil)
    object ||= get_item
    object_name = object.model_name.singular.gsub(/^(.+)user$/i, "user")
    "#{object_name}-#{object.id}"
  end

  def render_object
    object = get_item

    render object
  end

end
