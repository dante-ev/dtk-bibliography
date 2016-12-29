task default: [:nonascii, :clean, :pdf]

task ci: [:nonascii]

desc 'Delete all auxiliary LaTeX files'
task :clean do
  system('rm -f *.aux *.bbl *.bcf *.blg *.log *.out *.run.xml')
end

desc 'Show non-ASCII characters in bib file'
task :nonascii do
  found_characters = system('grep --color="auto" -P -n "[\x80-\xFF]" dtk-bibliography-ascii.bib')
  raise('Found non-ASCII characters in bib file!') if found_characters
  puts 'Success: Bib file is pure ASCII'
end

desc 'Build the full DTK bibliography list as PDF'
task :pdf do
  system('arara dtk-bibliography.tex')
end
