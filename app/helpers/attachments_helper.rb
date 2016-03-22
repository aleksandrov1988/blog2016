module AttachmentsHelper

  def show_attachment(attachment)
    "#{attachment.image_file_name} (#{number_to_human_size(attachment.image_file_size)})"
  end

  def link_to_attachment(attachment)
    link_to(attachment.image.url, title: attachment.title, data: {toggle: 'popover', content: "#{image_tag(attachment.image.url(:thumb))}", html: true, trigger: 'hover'}) do
      concat content_tag(:span, nil, class: 'glyphicon glyphicon-paperclip')
      concat show_attachment(attachment)
    end
  end
end
