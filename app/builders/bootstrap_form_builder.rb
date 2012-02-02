class BootstrapFormBuilder < ActionView::Helpers::FormBuilder
  def section(name, description="", &block)
    if !description.empty?
      description = @template.content_tag(:div, :class => "help") { description }
    end
    @template.content_tag :fieldset do
      @template.content_tag(:legend, name) + description + @template.capture(&block)
    end
  end

  %w[text_field password_field].each do |method_name|
    define_method(method_name) do |name, *args|
      @template.content_tag :div, :class => "clearfix" do
        label(name) + @template.content_tag(:div, :class => "input") do
          super(name, *args)
        end
      end
    end
  end

  def submit(name, *args)
    @template.content_tag :div, :class => "clearfix" do
      @template.content_tag(:div, :class => "input") do
        super(name, :class => "btn primary")
      end
    end
  end

  def errors
    if object.errors.any?
      @template.content_tag :div, :class => "alert-message" do
        @template.content_tag(:h3) { "Oops!" } +
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
