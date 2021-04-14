#include <iostream>
 
int main() {
 
  // Brain explodes here:
  for (int i=0; i <= 100; i++){

    if (i % 3 == 0 && i % 5 == 0) {
      std::cout << "FizzBuzz \n";
    }  

    if (i % 3 == 0) {
      std::cout << "Fizz \n";
    }  

    if (i % 5 == 0) {
    std::cout << "Buzz \n";
    }  

    else {
      std::cout << i << " None \n";
    }

  }

}
