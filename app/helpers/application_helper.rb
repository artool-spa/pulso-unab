module ApplicationHelper
  # Returns the full title on a per-page basis.
  def full_title(page_title='')
    base_title = "Pulso UNAB"
    if page_title.empty?
      raw base_title
    else
      raw "#{page_title} | #{base_title}"
    end
  end

  def flash_messages(opts = {})
    flash.each do |msg_type, message|
      concat(content_tag(:div, message, class: "alert #{bootstrap_class_for(msg_type)} alert-dismissible fade in") do
              concat content_tag(:button, '&times;'.html_safe, class: "close", data: { dismiss: 'alert' })
              concat message
            end) if message.present?
    end
    nil
  end

  def bootstrap_class_for flash_type
    { success: "alert-success", error: "alert-danger", danger: "alert-danger", alert: "alert-warning", notice: "alert-info" }[flash_type.to_sym] || flash_type.to_s
  end

  #
  # A simple google webfonts tag helper that generates tags for
  # all the font names called.
  #
  def font_tag(fontname_hash_or_array, *args)
    #
    # The message error.
    #
    message  = 'The font_tag() helper receives a single font definition in the format :fontname, size1, size2, '
    message += 'a multiple font definition in an array format [:fontname1, size1, size2], [:fontname2, size1, size2], '
    message += 'or a multiple font definition in the hash format {name: :fontname1, sizes: [size1, size2]},{name: :fontname2, sizes: [size1, size2]}'

    case fontname_hash_or_array
      when Symbol , String
        fontname = fontname_hash_or_array
        #
        # If the `fontname_hash_or_array` param is a symbol, then it's converted and processed as a string.
        #
        fontname = fontname.to_s.humanize.titleize if fontname.class == Symbol
        fontname = fontname.split(/ /).join('+')
        #
        # For a better understanding of the context
        #
        sizes = args
        size_definition = (sizes and !sizes.empty?) ? ":#{sizes.join(',')}" : nil
        raw "<link href='//fonts.googleapis.com/css?family=#{fontname}#{size_definition}' rel='stylesheet' type='text/css'/>"
      when Hash
        first_hash = fontname_hash_or_array
        tag = font_tag first_hash[:name], first_hash[:sizes]
        #
        # For a better understanding of the context
        #
        hashes = args
        unless (!hashes || hashes.empty?)
          hashes.each do |hash|
            raise message unless hash.class == Hash
            tag += "\n"
            tag += font_tag hash[:name], hash[:sizes]
          end
        end
        tag
      when Array
        first_array = fontname_hash_or_array
        tag = font_tag first_array.shift, first_array
        #
        # For a better understanding of the context
        #
        arrays = args
        unless (!arrays || arrays.empty?)
          arrays.each do |array|
            raise message unless array.class == Array
            tag += "\n"
            tag += font_tag array.shift, array
          end
        end
        tag
      else
        raise message
    end
  end

  # Generates a bootstrap modal
	def bootstrap_normal_modal(modal_id, title, modal_size='')
		raw %Q{
	<div id="#{modal_id}" class="modal fade #{modal_size}" tabindex="-1" role="dialog">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title">#{title}</h4>
	      </div>
	      <div class="modal-body">Cargando...</div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	        <button type="button" class="btn btn-primary">Save changes</button>
	      </div>
	    </div><!-- /.modal-content -->
	  </div><!-- /.modal-dialog -->
	</div><!-- /.modal -->
	}
	end

  def asset_exists?(subdirectory, filename)
    File.exists?(File.join(Rails.root, 'app', 'assets', subdirectory, filename))
  end

  def javascript_exists?(script)
    extensions = %w(.coffee .erb .coffee.erb) + [""]
    extensions.inject(false) do |truth, extension|
      truth || asset_exists?('javascripts', "#{script}.js#{extension}")
    end
  end
end
