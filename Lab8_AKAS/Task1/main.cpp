#include <iostream>
#include "getcpuid.h"
using namespace std;
int main()
{
 cpu_id cpuId = getcpuid();
 cout<<"CPUID: "<<hex<<cpuId.raw<<dec<<endl;
 cout<<"Family: "<<(unsigned)cpuId.family<<endl;
 cout<<"Model: "<<(unsigned)cpuId.model<<endl;
 cout<<"Stepping: "<<(unsigned)cpuId.stepping<<endl;
}
