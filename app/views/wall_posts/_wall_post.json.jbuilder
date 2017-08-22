json.extract! wallpost, :id, :body, :created_at, :updated_at
json.author wallpost.author, :id, :firstname, :lastname, :email, :avatar