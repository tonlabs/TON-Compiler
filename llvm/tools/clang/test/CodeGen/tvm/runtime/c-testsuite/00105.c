// RUN: %clang -w -O3 -S -c -target tvm %s -o - | tvm-testrun --no-trace --entry test_entry_point | FileCheck %S/shared.h

int
main()
{
	int i;

	for(i = 0; i < 10; i++)
		if (!i)
			continue;
	
	return 0;
}

#include "shared.h"
