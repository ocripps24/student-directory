def interactive_menu
  students = []
  loop do
    # 1. print the menu and ask the user what to do
    puts "1. Input the students"
    puts "2. Show the students"
    puts "9. Exit"
    # 2. read the input and save it into a variable
    selection = gets.chomp
    # 3. do what the user has asked
    case selection
      when "1"
        # input the students
        students = input_students
      when "2"
        # show the students
        print_header
        print(students)
        print_footer(students)
      when "9"
        exit # this will cause the program to terminate
      else
        puts "I don't know what you meant, try again"
      end
  end
end

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
      cohort: valid_cohort?(get_cohort)
    }
    if students.count == 1
      puts "Now we have #{students.count} student"
    else
      puts "Now we have #{students.count} students"
    end
    # get another name from the user
    name = gets.chomp
  end
  if !students.empty?
    return students
  else
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

def print(students)
  counter = 0
  until counter == students.length
    if students[counter][:name].length < 12
      puts "#{counter + 1}. #{students[counter][:name]} (#{students[counter][:cohort]} cohort)"
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


interactive_menu
