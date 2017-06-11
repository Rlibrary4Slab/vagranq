module ApplicationHelper
  def link_to_add_fieldsl(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
          render(association.to_s.singularize + "_fields", f: builder)
    end
    link_to(name, '#'   ,class: "add_fields add_fieldsl btn btn-lg btn-default", data: {id: id, fields: fields.gsub("\n", "")})
  end
  
  def link_to_add_fieldsf(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
          render(association.to_s.singularize + "_fields", f: builder)
    end
    link_to(name, '#'   ,class: "add_fields add_fieldsf btn btn-lg btn-default", data: {id: id, fields: fields.gsub("\n", "")})
  end

  def full_title(page_title)
     base_title = "RanQ [ランク]｜あなたの知りたいがランキングで分かる。" # 自分のアプリ名を設定する
     if page_title.empty?
      base_title
     else
      # "#{page_title} | #{base_title}"
      "#{page_title}"
     end
  end

  def embedded_svg filename, options={}
    file = File.read(Rails.root.join('app', 'assets', 'images', filename))
    doc = Nokogiri::HTML::DocumentFragment.parse file
    svg = doc.at_css 'svg'
    if options[:class].present?
      svg['class'] = options[:class]
    end
    doc.to_html.html_safe
  end

end
