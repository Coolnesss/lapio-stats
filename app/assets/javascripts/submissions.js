$(document).on('ready page:load', function(){
  var search = $("#search");
  search.focus();
  var submissions = $("#submissions tbody tr");
  search.keyup(function(event) {
    var filter = search.val();
    toggleMluukkai(filter === "mluukkai");
    submissions.each(function(index, elem) {
      var $elem = $(elem);
      var studentNumber = $elem.data("student");
      if (!studentNumber) return;
      $elem.toggle(studentNumber.indexOf(filter) !== -1);
    });
  })
});
