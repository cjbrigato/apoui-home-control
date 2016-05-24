$(function() {
    
    $("#search-form").submit(function () {
                var resource=$('#search_resource').val();
                var query=$('#search_query').val();
		var userobj={ "resource":resource, "query":query};
		$.ajax({
			url: "/web/resources/tables",
			type: "GET",
			data: userobj,
			success: function (result) { 
            		$('#response_table').html(result);
			resptable =  $('#response_table').DataTable( {
        "pageLength": 5,
         "search": {
          "search": query
                },
  "deferRender": true,
select: true,
"lengthChange": false,
"columnDefs": [ {
      "targets": [ -1,0 ],
      "searchable": false
    } ]
} );
			},
			error: function (request, status, error) {
//(request.responseText);
                        },

});
                return false;
        });
    });
