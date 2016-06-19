class Messenger

	def read_from_file
		filename = ("../test.htm")
		file = String.new
	 	#read file
	 	File.foreach(filename) do |f|
	 		file << f
	 	end

	 	file_divs = file.each_line('<div class="message">')

	 	file_divs.each do |div|
	 		from = between(div, "<span class=\"user\">", "</span>")
	 		date = between(div, "<span class=\"meta\">", "</span")
	 		message = between(div, "<p>", "</p>")
		 	messages << [from, date, message]
		end

		write_to_file(messages)

	end

	def write_to_file(messages)
		open("messenger-results.txt", 'w') do |f|
			messages.each do |message|
				line = "hi"
				#line = message[0] + ", " message[1] + ", " + message[2]
				f.puts line
			end
		end
	end

	#returns whats between start and finish
	#finish is FIRST occurance of string afterwards
	def between(line, start, finish)
		# split ABC into A|BC
		line_array = line.split(start)
		#return BC
		content = line_array[1]
		# remove C from | BC
		content = content.chomp(finish)
		#return B
		content
	end
end

m = Messenger.new
m.read_from_file
