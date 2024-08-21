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
  { name: 'Becky', age: 2, adopted: false, owner_id: nil },
  { name: 'Beckham', age: 4, adopted: false, owner_id: nil },
  { name: 'Max', age: 2, adopted: true, owner_id: owners.sample.id },
  { name: 'Mavis', age: 10, adopted: false, owner_id: nil },
  { name: 'Charlie', age: 1, adopted: false, owner_id: owners.sample.id },
  { name: 'Lucy', age: 5, adopted: true, owner_id: owners.sample.id },
  { name: 'Ludus', age: 1, adopted: false, owner_id: nil },
  { name: 'Rocky', age: 1, adopted: true, owner_id: owners.sample.id },
  { name: 'Rolly', age: 7, adopted: false, owner_id: nil }
]

Animal.insert_all(animals)

puts "Created #{Animal.count} animals."
