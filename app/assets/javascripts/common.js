$(document).on('turbolinks:load', function(){
  $("#new_rating input[name='rating[point]']").on('click', function () {
    $('#submit-rating').click();
  });
});
