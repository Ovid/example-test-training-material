# NAME

Sample Code From Ovid's Introductory Testing Course

# LICENSE

Releasing this code is an experiment in trying to balance giving back to the
community with our desire to push our business forward. As a result, please be
aware that [All Around The World](http://www.allaroundtheworld.fr) retains
copyright to this code and we request that it be used for personal use only.
This software is released AS-IS and no warranty is expressed or implied. We
make no promises as to its suitabality for anything at all.

This material is Copyright 2014 by [All Around The
World](http://www.allaroundtheworld.fr/) and is released under the
[Attribution-NonCommercial 3.0
Unported](http://creativecommons.org/licenses/by-nc/3.0/) license. This means
that you are free to:

* Share — copy and redistribute the material in any medium or format
* Adapt — remix, transform, and build upon the material

The licensor cannot revoke these freedoms as long as you follow the license terms.

Under the following terms:

* Attribution — You must give appropriate credit, provide a link to the license, and indicate if changes were made. You may do so in any reasonable manner, but not in any way that suggests the licensor endorses you or your use.
* NonCommercial — You may not use the material for commercial purposes.
* No additional restrictions — You may not apply legal terms or technological measures that legally restrict others from doing anything the license permits.

# WHAT IS THIS?

Recently I decided to completely redo how I teach testing at [All Around The
World](http://www.allaroundtheworld.fr/). I did this on the basis of my
experience in testing, teaching testing, going over other trainer's public
materials, and the latest advances in Perl. As a result, this course is
different from others. This repository is a sample of some of the training
material.

For example of how this course is different, many trainers start with showing
you how to print TAP directly:

    say "1..3";
    my $test = 1;
    say "ok ".$test++ if foo() == 1;
    say "ok ".$test++ if bar() == 2;
    say "ok ".$test++ if quux(7) == "bob";

Then they move on to `Test::Simple`:

    use Test::Simple tests => 3;

    ok foo() == 1, 'foo should be 1';
    ok bar() == 2, 'bar should be 2';
    ok quux(7) == "bob", 'quux(7) should be "bob"';

I assume that developers are smart enough to figure this out for themselves
and dive straight into `Test::More`. This saves time and allows us to get to
actual testing.

I also focus specifically on the most heavily used testing modules, such as
`Test::More`, `Test::Differences`, `Test::Exception` and so on.

The primary idea of this training is "real world" testing as you'll most
commonly find in a business environment. We show how to mock time, override
functions, write integration tests for legacy applications before refactoring,
understanding code coverage, testing scripts, and so on. However, we believe
that developers can look up many testing techniques for themselves so long as
they have a thorough grounding in the basics. For example, we don't cover
testing XML because [it's easy to lookup how to test XML in
Perl](https://metacpan.org/search?q=test+xml).

# USING THIS MATERIAL

The class is structured around a little explanation, followed by hands-on
testing, and then a sample answer. Then we have more explanation, more
hands-on testing and another sample answer. Wash, rinse, repeat.

To see the manual work, you can do this (note that lessons come before exams):

    $ git tag

    exam-1
    exam-1-answer
    example-1.9
    example-2.8
    lesson-1.1
    lesson-1.1-answer
    lesson-1.2
    lesson-1.2-answer
    lesson-1.3
    lesson-1.3-answer
    lesson-1.4
    lesson-1.4-answer
    lesson-1.5
    lesson-1.5-answer
    lesson-1.6
    lesson-1.6-answer
    lesson-1.7
    lesson-1.7-answer
    ... and so on

To work through this, you can:

    $ git checkout lesson-1.1
    ...
    $ prove -rl t
    t/math.t .. Undefined subroutine &main::sum called at t/math.t line 7.
    # Looks like your test exited with 255 before it could output anything.
    t/math.t .. Dubious, test returned 255 (wstat 65280, 0xff00)
    Failed 2/2 subtests 

    Test Summary Report
    -------------------
    t/math.t (Wstat: 65280 Tests: 0 Failed: 0)
      Non-zero exit status: 255
      Parse errors: Bad plan.  You planned 2 tests but ran 0.
    Files=1, Tests=0,  0 wallclock secs
    Result: FAIL

And then try to make the tests pass and add extra tests as you feel
appropriate. If you're curious about the approach used in class, you can do
this:

    git checkout lesson-1.1-answer

As we move forward through the course, the failures will be more verbose and
better explanations of what is needed are provided:

    $ git checkout lesson-2.1
    Previous HEAD position was b63f861... A diag() message to make the desired result clearer.
    HEAD is now at 4446a1b... A bad example of testing a complex data structure
    05:00:04 {(lesson-2.1)} ~/allaroundtheworld.fr/training/testing/code $ prove -rl t
    t/00-load.t .................... ok   
    t/tests/ovid/datastructures.t .. 1/? 
    #   Failed test 'abc.0 is 1'
    #   at t/tests/ovid/datastructures.t line 16.
    #          got: '3'
    #     expected: '1'

    #   Failed test '
    #   Rewrite these tests using a single 'is_deeply()' test, THEN fix the tests.
    #   We've provided an %expected data structure for you.
    # '
    #   at t/tests/ovid/datastructures.t line 19.
    # Looks like you failed 2 tests of 6.
    t/tests/ovid/datastructures.t .. Dubious, test returned 2 (wstat 512, 0x200)
    Failed 2/6 subtests 
    t/tests/ovid/datetime/tiny.t ... ok    
    t/tests/ovid/exam1.t ........... ok    
    t/tests/ovid/exporter.t ........ ok   
    t/tests/ovid/math.t ............ ok   
    t/tests/ovid/telepathy.t ....... skipped: Ovid::Telepathy cannot be loaded
    t/tests/ovid/utilities.t ....... ok   

    Test Summary Report
    -------------------
    t/tests/ovid/datastructures.t (Wstat: 512 Tests: 6 Failed: 2)
      Failed tests:  3, 6
      Non-zero exit status: 2
    Files=8, Tests=79,  0 wallclock secs 
    Result: FAIL

By reading carefully through the output, you can figure out where the tests
fail and try to figure out how to fix them.

# CAVEATS

This is here to show you how [All Around The
World](http://www.allaroundtheworld.fr/) approaches training. However, without
the trainer there to answer questions and without the slides, it may not
always be clear what's going on. Even if it is clear, you may have extra
questions about different approaches to problems. Having the code without the
training material is limiting, but I'm hoping that motivated individuals who
can't fly to France for training, or who can't bring me to your location may
still get some value out of this. Like I explained earlier, this is a
marketing experiment: how can we give back to the community but still build
our business? If this works, perhaps there will be more.
