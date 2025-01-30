# Remove first line of header in employee.csv
sed '1d' employee.csv | awk "
BEGIN {
  # Delimiter is ;
  FS = \";\"
  # Loop through each line of the file and sum the 4th column (salary) for each department
  # ID of the department is the 5th column
  # Lines come from the standard input
  while (getline < \"-\") {
    # If the department ID is not in the associative array, initialize it to 0
    if (!(\$5 in totalSalary)) {
      totalSalary[\$5] = 0
    }
    # Add the salary to the total salary of the department
    totalSalary[\$5] += \$4
  }
}
END {
  # Print the total salary of each department
  for (department in totalSalary) {
    print department, totalSalary[department]
  }
}
"