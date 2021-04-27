# While Loop Walkthrough
# count = 0
# print("Starting While Loop")
# while count <= 3:
#   # Loop Body
#   # Print if the condition is still true
#   print("Loop Iteration - count <= 3 is still true")
#   # Print the current value of count 
#   print("Count is currently " + str(count))
#   # Increment count
#   count += 1
# print("While Loop ended")



# Your code below: 
countdown = 10
while countdown >= 0: 
  print(countdown)
  countdown -= 1 
print("We have liftoff!")






python_topics = ["variables", "control flow", "loops", "modules", "classes"]

#Your code below: 
python_topics = ["variables", "control flow", "loops", "modules", "classes"]

#Your code below: 

length = len(python_topics)
index = 0

while index < length:
  print("I am learning about" + python_topics[index])
  index +=1

dog_breeds_available_for_adoption = ["french_bulldog", "dalmatian", "shihtzu", "poodle", "collie"]
dog_breed_I_want = "dalmatian"

for dog_breed in dog_breeds_available_for_adoption:
  print(dog_breed)
  if dog_breed == dog_breed_I_want:
    print("They have the dog I want!")
    break


#NESTED LOOPS
sales_data = [[12, 17, 22], [2, 10, 3], [5, 12, 13]]

scoops_sold = 0

for location in sales_data:
  print(location)
  for element in location:
    scoops_sold += element
    
print(scoops_sold)


#LIST COMPRHENSIONS
grades = [90, 88, 62, 76, 74, 89, 48, 57]

scaled_grades = [n + 10 for n in grades]
print(scaled_grades)

##
numbers = [2, -1, 79, 33, -45]
negative_doubled = [num * 2 for num in numbers if num < 0]
print(negative_doubled)

#####################

