module ApplicationHelper
  def link_to_add_fields(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
          render(association.to_s.singularize + "_fields", f: builder)
    end
    link_to(name, '#', style: "display: block;
  margin: 0 auto;
  width: 20px;
  height: 20px;
  line-height: 20px;
  border-radius: 50%;" ,class: "add_fields btn btn-lg btn-default", data: {id: id, fields: fields.gsub("\n", "")})
  end
end
