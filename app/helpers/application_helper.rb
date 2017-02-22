module ApplicationHelper

  def header(text)
    content_for(:header) { text.to_s }
  end


  def noty_type(name)
    name == 'notice' ? 'success' : 'error'
  end

  def link_to_back(name='Отмена')
    link_to name, :back, class: "btn btn-default"
  end

  def table_row(data)
    content_tag(:tr, data.map{|a| content_tag(:td, a)}.join('').html_safe).html_safe
  end

  def static(data)
    return nil unless data
    content_tag(:p, data.html_safe, class: 'form-control-static').html_safe
  end

  def icon(classes, title = nil, style = nil)
    content_tag :i, '', class: "fa #{classes}", title: title, style: style
  end

  def yes_or_no(expression)
    expression ? "Да" : "Нет"
  end

  def short_with_title(text, length, omission = '...')
    content_tag(:span, truncate(text, length: length, omission: omission), title: text)
  end

  def admin_edit_link(model)
    link_to content_tag(:i, "", class: "fa fa-edit"), [:edit, :admin, model], title: "редактировать"
  end

  def edit_link(path)
    link_to content_tag(:i, "", class: "fa fa-edit"), path, title: "редактировать"
  end

  def delete_link(path)
    link_to content_tag(:i, "", class: "fa fa-remove"), path, method: :delete, data: { confirm: "Удалить?" }, title: "удалить"
  end

  def delete_trash_link(path)
    link_to content_tag(:i, "", class: "fa fa-trash-o fa-fw"), path, method: :delete, data: { confirm: "Удалить?" }, title: "удалить"
  end

  def target_blank_link(url)
    link_to(url, url, target: "_blank") if url.present?
  end

  def short_date(date)
    date.try(:to_s, :russian)
  end

  def noty_type(name)
    name == 'notice' ? 'success' : 'error'
  end

  def alert_class(key)
    key == 'notice' ? 'success' : 'danger'
  end

  def money(amount, precision = 0, currency = 'rub')
    currency_class = (currency == 'rub' ? "fa fa-rub" : "fa fa-usd")
    number_to_currency(amount.to_f, precision: precision, delimiter: ".", unit: "") + " " + content_tag(:i, "", class: currency_class)
  end

  EMPTY_OPTION = { :id => 0, :name => "< Все >" }

  def html_options_for_transports(with_empty = false)
    empty = with_empty ? [Hashit.new(EMPTY_OPTION)] : []
    result = empty + Transport.all.map{ |s| Hashit.new({ :id => s.id, :name => s.name }) }
    # options_from_collection_for_select(result, :id, :name, 0)
  end

  # def example
  #   content_tag(:div) do
  #     content_tag(:div, class: "anton") do
  #       content_tag(:h1, "Важные дела фараона", class: "max") +
  #       content_tag(:ul, "Список покупок") do
  #         content_tag(:a, class: "btn btn-success") do
  #           content_tag(:i," Android", class:"fa fa-android fa-2x")
  #         end +
  #         content_tag(:li,"Батон") +
  #         content_tag(:li,"Колбаса") +
  #         content_tag(:li,"Молоко")
  #       end
  #     end
  #   end
  # end

  def static(data)
    return nil unless data
    content_tag(:p, data.html_safe, class: 'form-control-static').html_safe
  end

  def confirm_status(user)
    if user.confirmed_at
      icon("fa fa-check-square pointer", "Пользователь прошел активацию", "color: green")
    else
      icon("fa fa-clock-o pointer", "Пользователь ожидает активации", "color: brown")
    end
  end

  def yes_or_no_icon(n)
    n == 1 ? icon("fa fa-check-square pointer", nil, "color: green") : icon("fa fa-minus-square pointer", nil, "color: red")
  end

  def convenient_time(volunteer)
    "#{volunteer.convenient_start_time.strftime("%H:%M")}-#{volunteer.convenient_end_time.strftime("%H:%M")}"
  end

  def vacancy_full_info(vacancy)
    "#{vacancy.number}) #{vacancy.name} #{vacancy.starts_at.strftime("%H:%M")}-#{vacancy.ends_at.strftime("%H:%M")}"
  end

  def immediate_print
    <<-HTML
      <script type="text/javascript">
        $(document).ready(function(){
          if (window.print)
            window.print();
        });
      </script>
    HTML
  end

end

