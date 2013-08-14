# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Add roles
roles = Role.create([{ name: 'Super'}, { name: 'Admin'}, { name: 'Teacher'},
	{ name: 'Parent'}])

# Create super user and add to correct role
super_user = User.create(firstname: 'Rich', lastname: 'Caudle', email: 'richard@rcaudle.co.uk', 
	password: 'password')
UserRole.create(user_id: super_user.id, school_id: -1, class_id: -1, child_id: -1, role_id: roles.first.id)

# Create entry types
EntryType.create(name: 'Text')
EntryType.create(name: 'Observation')
EntryType.create(name: 'Photo')
EntryType.create(name: 'Art')

# Create learning areas
# LearningArea.create(name: 'Personal, Social & Emotional Development' )
# LearningArea.create(name: 'Physical Development' )
# LearningArea.create(name: 'Communication & Language' )
# LearningArea.create(name: 'Literacy' )
# LearningArea.create(name: 'Mathematics' )
# LearningArea.create(name: 'Understanding the World' )
# LearningArea.create(name: 'Expressive Arts & Design' )