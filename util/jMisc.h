#ifndef __MISC_H__
#define __MISC_H__

#ifdef  DEBUG
#define DEBUG_TEST 1
#else
#define DEBUG_TEST 0
#endif

namespace Jing{

typedef unsigned int size_t;
typedef unsigned int index_t;

#define debug_print(fmt)\
        do{if(DEBUG_TEST) fprintf(stderr, "%s:%d:%s() " fmt, __FILE__,\
                            __LINE__,__func__);} while(0)

}

#endif

