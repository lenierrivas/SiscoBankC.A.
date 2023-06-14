require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
	test 'render all users' do
		get users_path

		assert_response :success
		assert_select '.user', 2
	end

	test 'render details user page' do
		get user_path( users( :one ) )
		
		assert_response :success
	end

	test 'render new user page' do
		get new_user_path
		
		assert_response :success
		assert_select 'form'
	end

	test 'allow creating new user' do
		post users_path, params: {
			user: {
				type_person: 'natural',
				identification: '21119742',
				name: 'Lenier Rivas',
				email: 'lenierrivas.rl@gmail.com',
				tlf: '04125732391',
				tlf_second: '04125732391',
				emit: '2023-06-01',
				expiration: '2023-06-30'
			}
		}
		
		assert_redirected_to users_path
		assert_equal flash[:notice], 'Usuario registrado.'
	end

	test 'Does not allow creating new user with empty fields' do
		post users_path, params: {
			user: {
				type_person: '',
				identification: '215854855',
				name: 'Jose Garc',
				email: 'josejose@gmail.com',
				tlf: '+58458548585',
				tlf_second: '82858585496',
				emit: '1994/05/19',
				expiration: '1994/05/19'
			}
		}
		
		assert_response :unprocessable_entity
	end

	test 'render edit user from' do
		get edit_user_path( users(:one) )
		
		assert_response :success
		assert_select 'form'
	end

	test 'allow to edit user' do
		patch user_path( users(:one) ), params: {
			user: {
				type_person: 'natural',
				identification: '21119742',
				name: 'Lenier Rivas',
				email: 'lenierrivas.rl@gmail.com',
				tlf: '04125732391',
				tlf_second: '04125732391',
				emit: '2023-06-01',
				expiration: '2023-06-30'
			}
		}
		
		assert_redirected_to users_path
		assert_equal flash[:notice], 'Usuario Actualizado.'
	end

	test 'error edit user' do
		patch user_path( users(:one) ), params: {
			user: {
				type_person: nil,
			}
		}
	
		assert_response :unprocessable_entity		
	end

	test 'delete user' do
		assert_difference( 'User.count', -1 ) do	
			delete user_path( users( :one ) )
		end

		assert_redirected_to users_path
		assert_equal flash[:notice], 'Usuario Eliminado.'
	end
end