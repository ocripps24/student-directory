def input_students
  # Ask for user input
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  # Make the array to store the input
  students = []
  # Get the first name
  name = gets.chomp
  # Until the name is empty, repeat this code
  until name.empty? do
    # Add the student hash to the array
    students << {
      name: name,
      cohort: valid_cohort?(get_cohort),
      hobbies: :mischief,
      birth_place: :evilland,
      height: :"180cm"
    }
      if students.count == 1
        puts "Now we have #{students.count} student"
      else
        puts "Now we have #{students.count} students"
      end
    # get another name from the user
    name = gets.chomp
  end
  students
end

def get_cohort
  puts "Please enter the student's cohort as a 3 letter month entry: "
  cohort = gets.chomp.to_sym
end

def valid_cohort?(cohort)
  cohort_options = [
    :jan, :feb, :mar, :apr, :may, :jun,
    :jul, :aug, :sep, :oct, :nov, :dec
  ]
  if cohort.empty?
    return "november"
  elsif cohort_options.include?(cohort)
    return cohort
  else
    puts "Please review your spelling."
    cohort = valid_cohort?(get_cohort)
  end
end

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print(students)
  counter = 0
  until counter == students.length
    if students[counter][:name].length < 12
      puts "#{counter + 1}. #{students[counter][:name]} (#{students[counter][:cohort]} cohort) hobby: #{students[counter][:hobbies]}, birthplace: #{students[counter][:birth_place]}, height: #{students[counter][:height]}".center(100)
    end
    counter += 1
  end
end

def print_by_cohort(students)
  puts "which cohort to print?"
  cohort_input = gets.chomp.to_sym
  students.map { |student| puts "#{student[:name]} (#{student[:cohort]} cohort)" if student[:cohort] == cohort_input }
end

def print_footer(students)
  puts "Overall, we have #{students.count} great students"
end
# nothing happens until we call the methods
students = input_students
print_header
print(students)
print_footer(students)
print_by_cohort(students)
