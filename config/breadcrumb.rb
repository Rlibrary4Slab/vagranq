# Root crumb
crumb :root do
  link "Home", root_path
end

# Issue list
crumb :issues do
  link "All issues"
  parent :root
end