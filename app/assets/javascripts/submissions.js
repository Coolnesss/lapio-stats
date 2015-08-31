
jQuery(document).ready(function($){
  var search = $("#search");
  var submissions = $("#submissions tbody tr");
  search.keyup(function(event) {
    var filter = search.val();
    submissions.each(function(index, elem) {
      var $elem = $(elem);
      var studentNumber = $elem.data("student");
      if (!studentNumber) return;
      $elem.toggle(studentNumber.indexOf(filter) !== -1);
    });
  })
});
