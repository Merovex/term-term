require 'json'
file = 'pg29765.txt'

def titleize(word)
  word.downcase.gsub(/\b(?<!['â`])[a-z]/) { |match| match.capitalize }
end
def what(array)
	array.map do |p|
	  # raise p.split(/\n/).inspect
	  bits = p.split(/\n/)
	  term = titleize(bits.shift.split(';')[0])
	  defn = bits.join("\n")
	  {
	  	term: term,
	  	defn: defn
	  }
	end
end
nouns = []
adjs  = []
contents = File.read(file).split(/(?=\n[A-Z][A-Z][A-Z].*?\s)/)

i = 0 

contents.each do |c|
	adjs  << c.gsub(/^\n/,'').gsub(/\r/,'') if c.match(/a. Etym/)
	nouns << c.gsub(/^\n/,'').gsub(/\r/,'') if c.match(/n. Etym/)
	i += 1
	# break if i > 20000
end	

nouns = what(nouns)
adjs = what(adjs)
# raise nouns.inspect
dictionary = {
	'nouns' => nouns,
	'adjs' => adjs,
}.to_json
f = File.open('dictionary.json','w')
f.write(dictionary)
f.close