#include <stdio.h>
#include <iostream>

using namespace std;

int main() {
  
  cout << "Sum of 2 Matrix" << endl;
  int m1[2][2] = {{1,1},{1,1}};
  int m2[2][2] = {{3,4},{5,6}};
  int m3[2][2] = {};

  printf("{ \n");
  for(int i = 0; i < 2; i++) {
    printf(" { ");
    for(int j = 0; j < 2; j++) {
      m3[i][j] = m1[i][j] + m2[i][j];
      printf("%d ",m3[i][j]);
    }
    printf("} \n");
  }
  printf("}\n");



  return 0;
}