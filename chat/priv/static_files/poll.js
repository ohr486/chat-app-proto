function update() {
  $.ajax({
    url: '/room-update/room1',
    success: function(data) {
      $('#dataChange').text(data.date);
      $('#content').text(data.content);
      update();
    },
    timeout: 500000
    //timeout: 1000
  });
}

function load() {
  $.ajax({
    url: '/room/room1',
    success: function(data) {
      $('#content').text(data.content);
      update();
    }
  });
}

$(document).ready(function() {
  load();
});
