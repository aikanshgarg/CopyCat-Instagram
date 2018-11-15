// using javascript to show bootstrap popover component to display the result of search

$(document).ready(function(){
$("#users-search #term").on("keyup", function() { // keyup selects the users-search and the event is called whenever user starts typing!  
	var jqxhr = $.get(
		// "action" is the link to our form in the controller. In our case, action: "/users"
		// {term: ...} is like a json data
		// .val gives the value in the text-box (our search query)
		$("#users-search").attr("action"), 
		{term: $("#users-search #term").val()},
		function() {
			var result = $("#users-result").html();
			if(!result) {
				$("#users-search #term").popover({
					content: "No result found.",
					placement: "bottom",
					html: true,
					trigger: "focus"
				});
			} else {
				$("#users-search #term").popover({
					content: $("#users-result"),
					placement: "bottom",
					html: true,
					trigger: "focus"
				});
			}
			// now after checking the search result and putting it's value in popover, we call it by "show" method
			$("#users-search #term").popover("show");
		  }
		)
    })
});