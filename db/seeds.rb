# db/seeds.rb

Animal.destroy_all
Owner.destroy_all

# Create Owners
owners = [
  { name: 'John Doe' },
  { name: 'Alice Smith' },
  { name: 'Bob Smith' }
]

Owner.insert_all(owners)

puts "Created #{Owner.count} owners."

# Fetch all Owner records
owners = Owner.all

# Create Animals with association to Owners
animals = [
  { name: 'Bella', age: 3, adopted: true, owner_id: owners.sample.id },
  { name: 'Max', age: 2, adopted: false, owner_id: owners.sample.id },
  { name: 'Charlie', age: 1, adopted: false, owner_id: owners.sample.id },
  { name: 'Lucy', age: 5, adopted: true, owner_id: owners.sample.id },
  { name: 'Rocky', age: 1, adopted: true, owner_id: owners.sample.id }
]

Animal.insert_all(animals)

puts "Created #{Animal.count} animals."
