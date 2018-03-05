$(document).ready(function () {
 $("input[name=Tutorial]").click(function () {
  if ($(this).val() == "True") {
   $("#tutorial_hide").show('10000');
  } else {
   $("#tutorial_hide").hide('10000');
  }
 });

 $("input[name=Tutorial]").click(function () {
  if ($(this).val() == "True") {
   $("#tutorial_post").show('10000');
  } else {
   $("#tutorial_post").hide('10000');
  }
 });
});