(function (env) {
    "use strict";
    env.ddg_spice_real_estate = function(api_result){
        var res = api_result.FMRWidget$fmrresults.response;
        var data = res.results.result;

        if (!api_result || !data.length) {
            return Spice.failed('real_estate');
        }

        Spice.add({
            id: 'real_estate',
            name: 'Real Estate',
            view: 'Tiles',
            data: data,
            meta: {
                type: 'Homes',
                primaryText: 'Homes for sale near ' + cityState(', '),
                sourceName: 'Zillow',
                sourceUrl: 'https://www.zillow.com/homes/' + cityState('+').toLowerCase()
            },            
            normalize: normalize,            
            templates: {
                item: Spice.real_estate.item
            }
        });

        function normalize (obj) {
          return {
            name: obj.address.street.text,
            displayAddress: obj.address.street.text,
            url: obj.detailPageLink.text,
            displayImage: obj.largeImageLink.text,
            displayPrice: currency(obj.price.text),
            baths: plural(obj.bathrooms.text||0, 'bath'),
            beds: plural(obj.bedrooms.text||0, 'bed'),
            sqft: (obj.finishedSqFt.text||0) + ' sqft'
          };
        }

        function currency (n) {
          return '$' + String(n)
            .split('')
            .map(function(d,i,p){ return (!i||(p.length-i)%3)? d : ','+d })
            .join('');
        }

        function plural (n, word) {
          return parseInt(n) + ' ' + word + (n===1? '':'s');
        }

        function cityState (j) {
          return [res.region.city.text, res.region.state.text].join(j||' ');
        }
    };
}(this));
