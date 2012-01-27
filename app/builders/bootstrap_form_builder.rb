class BootstrapFormBuilder < ActionView::Helpers::FormBuilder
  def section(name, &block)
    @template.content_tag :fieldset do
      @template.content_tag(:legend, name) + @template.capture(&block)
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
end
