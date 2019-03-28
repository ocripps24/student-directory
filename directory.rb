def input_students
  # Ask for user input
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  # Make the array to store the input
  students = []
  # Get the first name
  name = gets.chomp
  # While the name is not empty, repeat this code
  while !name.empty? do
    # Add the student hash to the array
    students << {name: name, cohort: :november}
    puts "Now we have #{students.count} students"
    # get another name from the user
    name = gets.chomp
  end
  students
end

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print(students)
  student_count = 1
  students.each do |student|
    puts "#{student_count}. #{student[:name]} (#{student[:cohort]} cohort)"
    student_count += 1 
  end
end

def print_footer(students)
  puts "Overall, we have #{students.count} great students"
end
# nothing happens until we call the methods
students = input_students
print_header
print(students)
print_footer(students)
