$("#show").live("pageinit", function(event) {
	$.post('http://localhost:3000/mobiledownload.json', {}, function(data, code) {
		var html ='<ul>';
		for (var i = 0; i < data.length; i++) {
			adoption = data[i];
			html += '<li><b>' + adoption.title + '</b><p>' + adoption.descr + '</p>';
			html += '</li>';
		}
		html+='</ul>';
		$('#adoptions').html("hello");
	}, 'jsonp');
	$('#adoptions').html("hello2");
});

$("#submit").live('click', function() {
	$.post('http://localhost:3000/mobileupload.json', $('#new').serialize(), function(data) {
		if (data.error) {
			alert(data.error);
		} else {
			alert('Success!');
			$.mobile.changePage('index.html');
		}
	}, 'jsonp');
});