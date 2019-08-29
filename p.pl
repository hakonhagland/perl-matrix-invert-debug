#! /usr/bin/env perl

use feature qw(say);
use strict;
use warnings;

use Data::Printer;

# invert matrix
# An Efficient and Simple Algorithm for Matrix Inversion
# Ahmad Farooq, King Khalid University, Saudi Arabia
# Khan Hamid, National University of Computer and Emerging Sciences (NUCES),
# Pakistan
sub invert($)
{
    my $m = shift;          # matrix is an array of rows
    my ($pp, $det);
    my ($rp, $pe);
    my $n = scalar(@$m);

    for ($pp = 0, $det = 1.0; $pp < $n; ++$pp) {
        $rp = $m->[$pp];        # pivot row
        $pe = $rp->[$pp];       # pivot element
        last if ($pe == 0);      # Epsilon test?

        $det *= $pe;
        # calculate pivot column
        for (my $i = 0; $i < $n; ++$i) {
            next if ($i == $pp);
            $m->[$i][$pp] /= -$pe;
        }
        for (my $j = 0; $j < $n; ++$j) { # row index
            next if ($j == $pp);
            for (my ($i, $rj) = (0, $m->[$j]); $i < $n; ++$i) {
                next if ($i == $pp);
                $rj->[$i] += $rp->[$i] * $m->[$j]->[$pp];
            }
        }
        # calculate pivot row
        for (my $j = 0; $j < $n; ++$j) {
            next if ($j == $pp);
            $rp->[$j] /= $pe;
        }
        $rp->[$pp] = 1.0 / $pe;
        p $m;
        p $det;
        #exit;
    }

    return ($pe != 0.0, $det);
}

my $matrix = [[2,5],[1,3]];
my ($success, $det ) = invert( $matrix );

p $success;
p $det;


