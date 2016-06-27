require 'date'

class Messenger

	def read_from_file
		filename = ("../messages.htm")
		file = String.new
	 	#read file
	 	File.foreach(filename) do |f|
	 		file << f
	 	end

	 	file_divs = file.each_line('<div class="message">')
	 	first_flag = true
	 	messages = Array.new

	 	file_divs.each do |div|
	 		if first_flag 
	 			first_flag = false
	 		else
	 			#Debug, don't use for big files lol:			
		 			#puts  "\n++\n" + div + "\n++\n"
		 		from = between(div, "<span class=\"user\">", "</span><span class=\"meta\">")
		 		date = between(div, "<span class=\"meta\">", "</span")
		 		date_formatted = date_parser(date)
		 		message = between(div, "<p>", "</p>")
			 	messages << [from, date_formatted, message]
			end
		end

		write_to_file(messages)

	end

	#returns whats between start and finish
	#finish is FIRST occurance of string afterwards
	def between(line, start, finish)
		# split ABC into A|BC
		line_array = line.split(start)
		#return BC
		content = line_array[1]
		# remove C from | BC
		content = content.split(finish)

		if content[0].nil?
			content[0] = " "
		end

		#return B
		content[0]
	end

	def date_parser(date)
		#Tuesday, October 1, 2013 at 1:20pm PDT
		format = "%A, %B %e, %Y at %l:%M%P %Z"
		date = DateTime.strptime(date, format)
		#remember: to read time, use DateTime.strpTime(x)
		date_string = String(date)
	end

	def write_to_file(messages)
		open("../messenger-results.txt", 'w') do |f|
			messages.each do |message|
				puts "     from: " + message[0]
				puts "     on: " + message[1]
				puts "     message: " + message[2] 
				line = message[0] + ", " + message[1] + ", " + message[2]
				f.puts line
			end
		end
	end
end

m = Messenger.new
m.read_from_file
