$(document).on('turbolinks:load', function () {
  $(function () {
    $('#ramen_store_postcode').jpostal({
      postcode : [
        '#ramen_store_postcode'
      ],
      address : {
        '#ramen_store_prefecture_id'  : '%3',
        '#ramen_store_city'  : '%4%5',
        '#ramen_store_address' : '%6',
        '#ramen_store_building' : '%7'
      }
    });
  });
});