class User < ApplicationRecord

	## establecemos los parametros para el campo type_person
	enum type_person: {
	    natural: "Natural",
	    jurídica: "Jurídica"
  	}

  	## validaciones
		validates :type_person, presence: true

		validates :identification, presence: true

		validates :name, 
				presence: true, 
				length: { in: 3..35 },
				format: {
					with:  /\A[a-zA-Z\u00C0-\u017F\s]+\z/
				}

		validates :email, 
			presence: true, 
			format: { 
				with: /\A[a-zA-Z0-9.!\#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)+\z/
	 		} 

		validates :tlf, 
			presence: true,
			format: {
				with: /(0414|0424|0412|0416|0426)[0-9]{7}/
			}

	# validates :tlf_second,
		# format: {
		# 	with: /(0414|0424|0412|0416|0426)[0-9]{7}/ 
		# }

  		validates :emit, presence: true
  		validates :expiration, presence: true
  		validate :validate_not_future # ---> Validation date NOT future

	before_save :capitalize_attributes

	private
		## formatiamos los atributos
			def capitalize_attributes
				self.name = name.titleize
				self.email = email.downcase
			end
		## validamos las fechas ingresadas future or past
			def validate_not_future
				if emit.present? && emit.future?
					errors.add(:emit, "can't be in the future")
				end
				if expiration.present? && expiration.past?
					errors.add(:expiration, "can't be in the future")
				end


			# -------------------------------

				## BUSCAR COMO VALIDAR DESDE LA FUNCION ##
				# if type_person.present? && type_person == 'natural'
				# 	validates :identification, presence: true
				# end

			# -------------------------------



		end 
end
