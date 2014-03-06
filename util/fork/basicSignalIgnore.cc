#include<iostream>
#include<unistd.h>
#include<signal.h>
//#include<stdlib.h>

using std::cout;
using std::endl;

int main(int argc, char** argv){
  signal(SIGCHLD, SIG_IGN);

  fork();fork();fork();
  for(int i = 0; i < 100; ++i){
    cout << "rabbits!";
  }
  return 0;
}
