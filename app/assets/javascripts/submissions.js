
$(function() {
  var search = $("#search");
  var submissions = $("#submissions tbody tr");
  search.on('keyup', function(event) {
    var filter = search.val();
    submissions.each(function(index, elem) {
      var $elem = $(elem);
      $elem.toggle($elem.data("student").indexOf(filter) !== -1);
    });
  })
});
