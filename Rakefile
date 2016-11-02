task default: [:nonascii]

desc 'Show non-ASCII characters in bib file'
task :nonascii do
  found_characters = system('grep --color="auto" -P -n "[\x80-\xFF]" dtk-bibliography-ascii.bib')
  if found_characters
    raise('Found non-ASCII characters in bib file!') if exitstatus
  else
    puts 'Success: Bib file is pure ASCII'
  end
end
