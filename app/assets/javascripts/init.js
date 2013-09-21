;(function($){
	$(document).ready(function() {
		$('#main').children().each(function()
		{
			$(this).freetile({
				animate: true,
				elementDelay: 30
			});
		});
	});
})(jQuery)
				
