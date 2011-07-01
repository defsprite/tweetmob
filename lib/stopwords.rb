class Stopwords
  list = {}
  File.open("stopwords.txt", "r") do |file|
    while (line = file.gets)
      list[line.strip.downcase] = true
    end
  end
  LIST = list
end
