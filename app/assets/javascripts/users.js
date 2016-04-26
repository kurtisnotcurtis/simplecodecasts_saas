// This line will let jQuery wait for the DOM to load before continuing.
// Note that the load() method would wait until the entire page is loaded (e.g., images and iframes)
$(document).ready(function() {

  // Use method from Stripe's library (called in app layout) to retrieve Stripe public key from meta tag
  Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'));

  // Create event listener for a form submission from pro signup partial (using Pro Submit btn ID)
  $("#form-submit-btn").click(function(event) {
    
    // jQuery's preventDefault() method prevents the default action of the event from triggering
    event.preventDefault();
    
    // jQuery's prop() method is used to disable the submit button to prevent accidental user resubmittal
    $('input[type=submit]').prop('disabled', true);
    
    // Setting variable for error handling to false
    var error = false;
    
    // Use jQuery to load element values by ID into variables
    var ccNum = $('#card_number').val(),
        cvcNum = $('#card_code').val(),
        expMonth = $('#card_month').val(),
        expYear = $('#card_year').val();

    // If there are no errors...
    if (!error) {
      
      // Get Stripe token by passing CC vars as params to Stripe's createToken() method,
      // then run stripeResponseHandler func once token has been returned
      Stripe.createToken({
        number: ccNum,
        cvc: cvcNum,
        exp_month: expMonth,
        exp_year: expYear
      }, stripeResponseHandler);
    }
    return false;
  }); // form submission

  function stripeResponseHandler(status, response) {
    // Create a reference to the form
    var f = $("#new_user");

    // Get the token from the response param, passed as an argument by the Stripe createToken() method
    var token = response.id;

    // Add the token to the form in an appended, hidden input field
    f.append('<input type="hidden" name="user[stripe_card_token]" value="' + token + '" />');

    // Submit the form
    f.get(0).submit();
  }
});