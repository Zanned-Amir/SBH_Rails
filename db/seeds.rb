# db/seeds.rb

# Seed data for Category
Category.create(name: 'Electronics')
Category.create(name: 'Clothing')
Category.create(name: 'Books')
# Add more categories as needed

# Seed data for Permission
Permission.create(name: 'View')
Permission.create(name: 'Edit')
Permission.create(name: 'Delete')
# Add more permissions as needed

# Seed data for Role
Role.create(name: 'Admin')
Role.create(name: 'User')
# Add more roles as needed
