<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="css/main.css">
<title>Insert title here</title>

</head>
<body>
<table id="listaus">
	<thead>
		<tr>
			<th colspan="6" class="oikea"><span id="uusiAsiakas">Lis�� uusi asiakas</span></th>
		</tr>
		
		<tr>
		<th class="oikea">Hakusana:</th>
		<th colspan="4"><input type="text" id="hakusana"></th>
		
		<th style= "text-align: left;">
		<input type="button" value="hae" id="hakunappi">
		</th>
		
		</tr>
		
		<tr class="taulu">
			<th>Asiakasid</th>
			<th>Etunimi</th>
			<th>Sukunimi</th>
			<th>Puhelin</th>
			<th>Sposti</th>
			<th></th>
		</tr>
		</thead>
		<tbody>
		</tbody>
</table>
<script>
$ (document).ready(function() {
	
	$("#uusiAsiakas").click(function() {
		document.location="lisaaasiakas.jsp";
	});
	
	haeAsiakkaat();
	$("#hakunappi").click(function(){
		console.log($("#hakusana").val());
		haeAsiakkaat();
	});
	$(document.body).on("keydown", function(event){
		if (event.which==13){
			haeAsiakkaat();
		}
	});
	$("#hakusana").focus();
});

function haeAsiakkaat(){
	$("#listaus tbody").empty();
	$.ajax({url:"asiakkaat/"+$("#hakusana").val(), type:"GET", dataType:"json", success:function(result){		
		$.each(result.asiakkaat, function(i, field){  
        	var htmlStr;
        	htmlStr+="<tr id='rivi_"+field.asiakasid+"'>";
        	htmlStr+="<td>"+field.asiakasid+"</td>";
        	htmlStr+="<td>"+field.etunimi+"</td>";
        	htmlStr+="<td>"+field.sukunimi+"</td>";
        	htmlStr+="<td>"+field.puhelin+"</td>";
        	htmlStr+="<td>"+field.sposti+"</td>";  
        	htmlStr+="<td><span class='poista' onclick=poista('"+field.asiakasid+"')>poista</span></td>";
        	htmlStr+="</tr>";
        	$("#listaus tbody").append(htmlStr);
        });	
    }});
}

function poista(asiakasid) {
	if(confirm("Poista asiakas " + asiakasid +"?")) {
		$.ajax({url:"asiakkaat/"+asiakasid, type:"DELETE", dataType:"json", success:function(result) {
			if(result.response==0){
				$("#ilmo").html("Asiakkaan poisto ep�onnistui.")
			} else if(result.response==1){
				$("#rivi_"+asiakasid).css("background-color", "red");
				alert("Asiakkaan " + asiakasid + " poisto onnistui.");
				haeAsiakkaat();
			}
		}});
	}
}


</script>

</body>
</html>