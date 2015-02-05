$(document).ready(function() {
  $("#fat-after")
  //   .css("background-color", "#D17519", function() {
  //   });
    .on("mouseover", function() {
      $(this).css("background-color", "#000000");
    })
    .on("mouseleave", function() {
      $(this).css("background-color", "#D17519");
    });
});
