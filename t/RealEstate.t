#!/usr/bin/env perl

use strict;
use warnings;
use Test::More;
use DDG::Test::Spice;

spice is_cached => 1;

ddg_spice_test(
    [qw( DDG::Spice::RealEstate)],
    'real estate in seattle' => test_spice(
        '/js/spice/real_estate/seattle',
        call_type => 'include',
        caller => 'DDG::Spice::RealEstate'
    ),

    'homes for sale portland' => test_spice(
        '/js/spice/real_estate/portland',
        call_type => 'include',
        caller => 'DDG::Spice::RealEstate'
    ),

    'homes in irvine ca' => test_spice(
        '/js/spice/real_estate/irvine%20ca',
        call_type => 'include',
        caller => 'DDG::Spice::RealEstate'
    ),

# Try to include some examples of queries on which it might
    # appear that your answer will trigger, but does not.
    'zillow seattle' => undef,
    'real estate' => undef
);

done_testing;
