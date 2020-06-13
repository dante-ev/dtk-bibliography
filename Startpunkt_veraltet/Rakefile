task default: [:nonascii, :clean, :pdf]

task ci: [:nonascii]

desc 'Delete all auxiliary LaTeX files'
task :clean do
  system('rm -f *.aux *.bbl *.bcf *.blg *.log *.out *.run.xml')
end

desc 'Show non-ASCII characters in bib file'
task :nonascii do
	File.readlines('dtk-bibliography-ascii.bib').each do |li|
  		if li =~ /[^[:ascii:]]/
  			puts li
 			raise('Found non-ASCII characters in bib file!')
  		end
	end
end

desc 'Build the full DTK bibliography list as PDF'
task :pdf do
  system('arara dtk-bibliography.tex')
end
