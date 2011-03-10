Before('@firefox') do
  Capybara.current_driver = :selenium
end

Before('@chrome') do
  Capybara.current_driver = :selenium_chrome
end

AfterStep('@pause') do
  puts ""
  puts "Browser is paused!"
  puts "Press Enter to continue..."
  STDIN.getc
end
