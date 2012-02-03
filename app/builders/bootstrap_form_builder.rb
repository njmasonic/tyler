class BootstrapFormBuilder < ActionView::Helpers::FormBuilder
  def section(name, description="", &block)
    if !description.empty?
      description = @template.content_tag(:div, :class => "help") { description }
    end
    @template.content_tag :fieldset do
      @template.content_tag(:legend, name) + description + @template.capture(&block)
    end
  end

  def actions(&block)
    @template.content_tag(:div, :class => "form-actions") do
      @template.capture(&block)
    end
  end

  %w[text_field password_field].each do |method_name|
    define_method(method_name) do |name, *args|
      @template.content_tag(:div, :class => "control-group") do
        label(name) + @template.content_tag(:div, :class => "controls") do
          super(name, *args)
        end
      end
    end
  end

  def email_field(name, *args)
    @template.content_tag(:div, :class => "control-group") do
      label(name) + @template.content_tag(:div, :class => "controls") do
        @template.content_tag(:div, :class => "input-prepend") do
          @template.content_tag(:span, :class => "add-on") do
            @template.content_tag(:i, :class => "icon-envelope") {}
          end + super(name, *args)
        end
      end
    end
  end

  def submit(name, *args)
    super(name, :class => "btn btn-primary")
  end

  def errors
    if object.errors.any?
      @template.content_tag :div, :class => "alert" do
        @template.content_tag(:h4, :class => "alert-heading") { "Oops!" } +
        @template.content_tag(:ul) do
          object.errors.collect do |attribute, message|
            @template.content_tag(:li) { error_message_for(attribute, message) }
          end.join.html_safe
        end
      end
    end
  end

  private

  def error_message_for(attribute, message)
    return message if attribute == :base
    attr_name = /^(.*\.)?(.*)$/.match(attribute.to_s)[2].humanize
    attr_name = object.class.human_attribute_name(attribute, :default => attr_name)
    I18n.t(:"errors.format", {
      :default   => "%{attribute} %{message}",
      :attribute => attr_name,
      :message   => message
    })
  end
end
