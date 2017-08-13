// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).on("turbolinks:load", function(){
  
    var myClickMention = function(){
      $("div#wallpost").addClass("hidden");
      $("div#mention").removeClass("hidden");
      $("li#li-mention-friend").addClass("is-active")
      $("li#li-only-you").removeClass("is-active")
    };
  
    $("a#mention-friend").on('click', myClickMention);

    var myClickYou = function(){
      $("div#wallpost").removeClass("hidden");
      $("div#mention").addClass("hidden");
      $("li#li-mention-friend").removeClass("is-active")
      $("li#li-only-you").addClass("is-active")
    };
  
    $("a#only-you").on('click', myClickYou);

  });