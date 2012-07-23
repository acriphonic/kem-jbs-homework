var server='http://localhost:3000';

$("#show").live("pageinit", function(event) {
	var page = $("#createtourpage");
	$.get(server+'/mobiledownload.json', {}, function(data, textStatus, jqXHR) {
		var html='<ul>';
		for (var i=0; i<data.length; i++) {
			listing=data[i];
			html+='<li><b>'+listing.title+'</b><p>'+listing.descr+'</p>';
			html+='</li>';
		}
		html+='</ul>';
		$('#adoptions').html(html);
	}, 'jsonp');
});

$("#submit").live('click', function() {
	$.post(server+'/mobileupload.json', $('#create').serialize(), function(data) {
		if (data.error) {
			alert(data.error);
		} else {
			alert('Success!');
			$.mobile.changePage('index.html');
		}
	}, 'jsonp');
});