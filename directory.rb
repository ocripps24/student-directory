@students = [] # an empty array accessible to all methods

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "4. Load the list from students.csv"
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
    when "3"
      save_students
    when "4"
      load_students
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
  name = STDIN.gets.chomp
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
    name = STDIN.gets.chomp
  end
  if @students.empty?
    return input_students
  end
end

def get_cohort
  puts "Please enter the student's cohort as a 3 letter month entry: "
  cohort = STDIN.gets.chomp.to_sym
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
  cohort_input = STDIN.gets.chomp.to_sym
  @students.map { |student| puts "#{student[:name]} (#{student[:cohort]} cohort)" if student[:cohort] == cohort_input }
end

def print_footer
  puts "Overall, we have #{@students.count} great students"
end

def save_students
  # open the file for writing
  file = File.open("students.csv", "w")
  # iterate over the array of students
  @students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
end

def load_students(filename = "students.csv")
  file = File.open(filename, "r")
  file.readlines.each do |line|
  name, cohort = line.chomp.split(",")
    @students << {name: name, cohort: cohort.to_sym}
  end
  file.close
end

def try_load_students
  filename = ARGV.first # first argument from the command line
  return if filename.nil? # get out of the method if it isn't given
  if File.exists?(filename) # if it exists
    load_students(filename)
    puts "Loaded #{@students.count} from #{filename}"
  else # if it doesn't exist
    puts "Sorry, #{filename} doesn't exist."
    exit # quit the program
  end
end

# nothing happens until we call the methods
try_load_students
interactive_menu
