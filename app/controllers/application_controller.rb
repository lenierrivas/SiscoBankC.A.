class ApplicationController < ActionController::Base
	include Pagy::Backend

	around_action :switch_locale
	before_action :turbo_frame_request_variant

	private
		## funcionabilidad del search en el index con turbo
			def turbo_frame_request_variant
				request.variant = :turbo_frame if turbo_frame_request?
			end
		
		## funcionabilidad de las traducciones
			def switch_locale( &action )
				I18n.with_locale( locale_from_header, &action )
			end

			def locale_from_header
				request.env['HTTP_ACCEPT_LANGUAGE']&.scan(/^[a-z]{2}/)&.first
		end
end
