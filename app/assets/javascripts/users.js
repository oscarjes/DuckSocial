// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).on("turbolinks:load", function(){

  var myClick = function(){
    $("div#password-change").toggleClass("hidden");
  };

  $("a#password-toggle-icon").on('click', myClick);


  var options = {
    url: function(phrase) {
      return "users/search?q=" + phrase + "&format=json";
    },

    getValue: "firstname",

    list: {
          onChooseEvent: function() {
            var name = $("#provider-remote").getSelectedItemData().firstname;
            var value = $("#provider-remote").getSelectedItemData().id;

           
            $("#data-holder-selected").append("<li>" + name + "</li>").trigger("change");
            $("#data-holder").val($("#data-holder").val() + "," + value).trigger("change");
          }
        }
  };

  $("#provider-remote").easyAutocomplete(options);

  var optionsNav = {
    url: function(phrase) {
      return "users/search?q=" + phrase + "&format=json";
    },

    getValue: "firstname",

    list: {
          onChooseEvent: function() {
            var value = $("#provider-remote").getSelectedItemData().id;

            $("#data-holder-nav").val(value).trigger("change");
            
          }
        }
  };

  $("#provider-remote-nav").easyAutocomplete(optionsNav);
});