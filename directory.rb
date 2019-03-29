@students = [] # an empty array accessible to all methods

def interactive_menu
  loop do
    print_menu
    process(gets.chomp)
  end
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "9. Exit"
end

def show_students
  print_header
  print_student_list
  print_footer
end

def process(selection)
  case selection
    when "1"
      input_students
    when "2"
      show_students
    when "9"
      exit
    else
      puts "I don't know what you meant, try again"
  end
end

def input_students
  # Ask for user input
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  # Get the first name
  name = gets.chomp
  # Until the name is empty, repeat this code
  until name.empty? do
    # Add the student hash to the array
    @students << {
      name: name,
      cohort: valid_cohort?(get_cohort)
    }
    if @students.count == 1
      puts "Now we have #{@students.count} student"
    else
      puts "Now we have #{@students.count} students"
    end
    # get another name from the user
    name = gets.chomp
  end
  if @students.empty?
    return input_students
  end
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
    return "nov"
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

def print_student_list
  counter = 0
  until counter == @students.length
    puts "#{counter + 1}. #{@students[counter][:name]} (#{@students[counter][:cohort]} cohort)"
    counter += 1
  end
end

def print_by_cohort
  puts "which cohort to print?"
  cohort_input = gets.chomp.to_sym
  @students.map { |student| puts "#{student[:name]} (#{student[:cohort]} cohort)" if student[:cohort] == cohort_input }
end

def print_footer
  puts "Overall, we have #{@students.count} great students"
end

# nothing happens until we call the methods
interactive_menu
