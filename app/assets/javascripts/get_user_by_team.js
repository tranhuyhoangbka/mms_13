$(".projects.new").ready(function(){
  func();
});

$(".projects.edit").ready(function(){
  func();
});

func = function(){
  $("select#project_team_id").change(function(){
    var id_value_string = $(this).val();
    if (id_value_string == "") {
      $("select#project_leader_id option").remove();
      var row = "<option value=\"" + "" + "\">" + "" + "</option>";
      $(row).appendTo("select#project_leader_id");
    }
    else {
      $.ajax({
        dataType: "json",
        cache: false,
        url: '/admin/projects/get_user_by_team/' + id_value_string,
        error: function(XMLHttpRequest, errorTextStatus, error){
          alert("Failed to submit : " + errorTextStatus+ " ; " + error);
        },
        success: function(data){
          $("select#project_leader_id option").remove();
          var row = "<option value=\"" + "" + "\">" + "" + "</option>";
          $(row).appendTo("select#project_leader_id");
          $.each(data, function(i, j){
            row = "<option value=\"" + j.id + "\">" + j.name + "</option>";
            $(row).appendTo("select#project_leader_id");
          });            
         }
      });
    };
  });
}