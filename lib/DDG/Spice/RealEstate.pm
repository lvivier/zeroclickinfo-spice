package DDG::Spice::RealEstate;
# ABSTRACT: Search for real estate on zillow.com

use DDG::Spice;
use Text::Trim;
use URI::Escape;

my $z_key = $ENV{'DDG_SPICE_ZILLOW_APIKEY'};
my $z_url = 'http://zillow.com/webservice/FMRWidget.htm?status=forSale&zws-id=' . $z_key . '&region=';

name "Real Estate";
source "Zillow";
icon_url "/i/zillow.com.ico";
description "Search for real estate";
primary_example_queries "seattle real estate", "homes for sale in portland";
category "location_aware";
code_url "https://github.com/duckduckgo/zeroclickinfo-spice/blob/master/lib/DDG/Spice/RealEstate.pm";
attribution github => ['lvivier', 'Luke Vivier'],
            email  => ['lukev@zillow.com', 'Luke Vivier'];

triggers any => "real estate", "homes for sale", "homes in", "properties in";

spice to => 'https://duckduckgo.com/x.js?u=' . uri_escape($z_url) . '$1';
spice wrap_jsonp_callback => 1;

handle remainder => sub {
    return unless $_;

    s/.*\b(in|at|near|around|listings)\b\s*(.*)/$2/i;
    trim();

    return $_;
};

1;
