task default: [:nonascii]

desc 'Delete all auxiliary LaTeX files'
task :clean do
  system('rm -f *.aux *.bbl *.bcf *.blg *.log *.out *.run.xml')
end

desc 'Show non-ASCII characters in bib file'
task :nonascii do
  found_characters = system('grep --color="auto" -P -n "[\x80-\xFF]" dtk-bibliography-ascii.bib')
  if found_characters
    raise('Found non-ASCII characters in bib file!') if exitstatus
  else
    puts 'Success: Bib file is pure ASCII'
  end
end
