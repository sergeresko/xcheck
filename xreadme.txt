# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    xreadme.txt                                        :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: syeresko <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2018/11/25 13:26:53 by syeresko          #+#    #+#              #
#    Updated: 2018/11/30 20:42:14 by syeresko         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #


=== PREPARATION ===

Copy the files from this directory to the root of your ft_printf repository.
The names of all these files start with letter 'x' for convenience, so that
they hopefully don't mix with your own files.
Alternatively, if you want to keep them in a separate directory, open the file
"xmake" with a text editor and specify the path to your "libftprintf.a" there.

To let the shell scripts be executed without prepending "sh" each time, run
	"chmod +x xmake"
	"chmod +x x"



=== GENERAL USAGE ===

/-------------------------------\
|	...							|
|		(all your source files)	|
|	Makefile					|
|		(your Makefile)			|
\-------------------------------/
				|
				|		"make" OR "make re"
				|			(run this if you need to rebuild your library,
				|			for example, if you have modified your source files)
				V
/-------------------------------\
|	libftprintf.a				|
|		(your library)			|
|	xcheck.c					|
|		(don't touch this file)	|
|	xtests.h					|	<----	TESTS ARE HERE
|		(tests you can expand)	|
\-------------------------------/
				|
				|		"./xmake"
				|			(run this if you have run the previous command
				|			or modified the file "xtests.h")
				V
/-------------------------------\
|	xcheck						|
|		(compiled tests)		|
\-------------------------------/
				|
				|		"./x"
				|			(run this to see the list of all tests)
				|		"./x TEST_NAME" OR "./x TEST_NUMBER"
				|			(run this to see the diff for a particular test)
				|		"./x -PREFIX"
				|			(run this to see the diff for all tests whose names
				|			start with a particular prefix, e.g. "./x -Bu")
				V
/-------------------------------\
|	xout_ft.txt					|
|		(ft_printf's output)	|
|	xout_libc.txt				|
|		(printf's output)		|
\-------------------------------/

Since "./x PARAMETER" displays a diff, if nothing appears on the screen, it
means that your ft_printf has successfully passed a test.

If you don't want to compare ft_printf and printf, but just want to see the
output produced by either of these functions, you may run
	"./xcheck 1 PARAMETER" (for ft_printf)
	OR
	"./xcheck 2 PARAMETER" (for printf)
where PARAMETER is the same as for "./x PARAMETER" described above.
Alternatively, you may run
	"./x PARAMETER"
and then
	"cat xout_ft.txt"
	OR
	"cat xout_libc.txt" 



=== TEST NAMING CONVENTION ===

The name of a test is composed of the following three parts in succession:
1.	a capital letter B, H, U, X, or M
		B means a BASIC test: ft_printf must work exactly as printf.
		H means a HARD test: even if output differs, one can forgive this.
		U means a test where printf has UNDEFINED BEHAVIOR.
		X means an EXTRA test for bonus features not required in the subject.
		M means a MIXED test comprising miscellaneous test cases.
2.	1)	either one of the letters d, i, o, u, x, X, s, c, p, f, ...
		(if the test is designed for a speific conversion)
	2)	or an underscore (_)
		(if the test doesn't involve a conversion or has different conversions)
3.	an arbitrary sequence of alphanumeric characters
		(a concise description)

Good test names are, for example:
	B_percent	(a basic test for "%%" conversion)
	Hf_1e150	(a hard test for "%f" that checks such numbers as 10^150)
	U_2stars	(a test for "%**", which is undefined by the standard)
	Xs_wide		(an extra test for "%ls")
	M_xlogin	(a test with various stuff by <xlogin> who was too lazy to
				classify his/her test cases and give them appropriate names)
Bad test names are, for example:
	test001
	qweqweqwe

This naming strategy allows, for example, to invoke all basic tests by running
"./x -B" or all tests for "%e" by running "./x -Xe" (see lines 63-65).
You might have already guessed that "./x -" would execute all available tests.

NOTE:	For the purposes of nice formatting, test names should be no longer
		than 15 characters.



=== TEST SYNTAX ===

All tests reside in a text file named "xtests.h" and are written in the form
of macros. You're encouraged to add your own tests to that file.

There are six macros: PF, TEST, END, TEST_ITER, ALL_TESTS, and T. If you
examine "xtests.h" and have a look at the output files, you'll easily figure
out what these macros do and how to use them.

There are two kinds of tests: a plain test (TEST) and an iterative test
(TEST_ITER). The names of the tests are indicated as the argument of a TEST
macro or as the first argument of a TEST_ITER macro. For instance, the
following two tests (called "Bs_example") virtually do the same thing:

1.	TEST(Bs_example)
		PF("It %010s an %s", "is", "example")
		PF("It %010s an %s", "could be", "example")
		PF("It %010s an %s", "won't count as", "example")
		PF("It %-9s an %.2s", "is", "example")
		PF("It %-9s an %.2s", "could be", "example")
		PF("It %-9s an %.2s", "won't count as", "example")
	END

2.	#define _Bs_example(x)\
		PF("It %010s an %s", x, "example")\
		PF("It %-9s an %.2s", x, "example")
	TEST_ITER(Bs_example, "is", "could be", "won't count as")

NOTE 1:	There is NO SEMICOLON ';' after a PF call.
NOTE 2:	There is NO BACKSLASH '\' in the last line of a #define.
NOTE 3:	The name in a #define must be the same as the first argument of the
		following TEST_ITER, but with an underscore at the beginning.
NOTE 4:	If you add your tests, don't forget to list their names in ALL_TESTS
		at the end of the file in the format T(name).



=== GOOD LUCK! ===
