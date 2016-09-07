$(document).on('ready page:load turbolinks:load', function(){

  $("#submissions").tablesorter({sortList: [[1,0]]});

  var search = $("#search");
  search.focus();
  var submissions = $("#submissions tbody tr");
  search.keyup(function(event) {
    var filter = search.val();
    toggleMluukkai(filter === "mluukkai");

    // Update the URL with the current search filter.
    if (window.history.replaceState) {
      window.history.replaceState({}, "", "?search=" + filter)
    }

    submissions.each(function(index, elem) {
      var $elem = $(elem);
      var studentNumber = $elem.find(".student-id").text();
      if (!studentNumber) return;
      $elem.toggle(studentNumber.indexOf(filter) !== -1);
    });
  })
});
