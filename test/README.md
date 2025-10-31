# program_status_word_verification
Did this project to practice uvm_based_verification along with formal verification.
Acheived 100% functional coverage by passing 5 test cases.
successfully verified with including 5 assertions.
Learned about the importance of timing in assertion based verification and randomization in functional verification.
Learned how to develop a fully functional scoreboard with covergroup in it.
Challenges Faced:->
WHILE DEBUGGING:->
GOT ASSERTION FAILURES:->
Found it was with timing(by adding traces and mentioning expected,actual values and $time).
Then as the dut is sequential and evaluates the inputs after 1 cycle i've used non_overlapping operator with $past applying on inputs so in such a way even if the combinational inputs change it takes the expected value through $past.
Finally solved the timing error and got 100% FUNCTIONAL COVERAGE.
