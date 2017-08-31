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

  var points = {}
  if (window.location.href.includes("submissions") || $("#dropdown").length) {
    $.getJSON(window.location.origin + "/weeks.json", function (response) {
      response.forEach(function (week) {
        points[week.id] = week.max_points
      })
      onDropdownChange()
    var weekId = $("#dropdown").length
                    ? parseInt($("#dropdown").val())
                    : parseInt($("#submission-week-id").text())
    $("#dropdown").unbind('change');
    $("#dropdown").on("change", onDropdownChange);
    $("#submission-points").val(0)
    for (let i = 1; i <= points[weekId]; i++) {
      $('#checkbox-' + i).on("change", onCheckboxChecked);
    }
  })
}

  function onDropdownChange() {
    $("#points-container").html('')
    $("#submission-points").val(0)
    for (let i = 1; i <= points[parseInt($("#dropdown").val())]; i++) {
      $("#points-container").append('<input type="checkbox" id="checkbox-' + i + '"> Exercise ' + i +'</input><br>')
    }
  }

  function onCheckboxChecked(e) {
    console.log(e)
    var checked = e.target.checked
    var diff = checked ? 1 : -1;
    $("#submission-points").val(parseInt($("#submission-points").val()) + diff)
    console.info(parseInt($("#submission-points").val()) + diff)
  }
});

