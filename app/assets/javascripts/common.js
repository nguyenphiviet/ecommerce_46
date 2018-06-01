$(document).on('turbolinks:load', function(){
  $("#new_rating input[name='rating[point]']").on('click', function () {
    $('#submit-rating').click();
  });
  $('.quantity').on('change', function(){
    var quantity = $(this).val();
    var product_id = $(this).prev('input').val();
    $.ajax({
      url: 'items/' + product_id,
      method: 'PUT',
      data: {quantity: quantity}
    });
  });
});
