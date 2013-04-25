conditionally('jira.disabled?', false) do
  gem 'jira-ruby', require: 'jira'
end
