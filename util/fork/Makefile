default:foobar

foobar:test.o
	g++ -Wall test.o -o foobar

test.o:test.cc
	g++ -c -Wall test.cc

clean:
	rm *.o core foobar

