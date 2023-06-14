class AddNullFalseToUserFields < ActiveRecord::Migration[7.0]
    def change
        change_column_null :users, :type_person, false
        change_column_null :users, :identification, false
        change_column_null :users, :emit, false
        change_column_null :users, :expiration, false
        change_column_null :users, :name, false
        change_column_null :users, :email, false
        change_column_null :users, :tlf, false
        change_column_null :users, :tlf_second, false
    end
end
